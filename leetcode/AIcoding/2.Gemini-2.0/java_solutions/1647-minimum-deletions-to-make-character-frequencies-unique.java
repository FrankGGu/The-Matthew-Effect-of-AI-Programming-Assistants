import java.util.HashSet;
import java.util.PriorityQueue;
import java.util.Set;

class Solution {
    public int minDeletions(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        for (int f : freq) {
            if (f > 0) {
                pq.offer(f);
            }
        }

        int deletions = 0;
        Set<Integer> seen = new HashSet<>();

        while (!pq.isEmpty()) {
            int curr = pq.poll();

            while (curr > 0 && seen.contains(curr)) {
                curr--;
                deletions++;
            }

            if (curr > 0) {
                seen.add(curr);
            }
        }

        return deletions;
    }
}