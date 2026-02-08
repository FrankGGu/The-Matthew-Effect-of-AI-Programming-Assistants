import java.util.HashMap;
import java.util.HashSet;
import java.util.PriorityQueue;
import java.util.Set;

class Solution {
    public int minDeletions(String s) {
        int[] freqMap = new int[26];
        for (char c : s.toCharArray()) {
            freqMap[c - 'a']++;
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a); // Max-heap
        for (int freq : freqMap) {
            if (freq > 0) {
                pq.offer(freq);
            }
        }

        Set<Integer> usedFrequencies = new HashSet<>();
        int deletions = 0;

        while (!pq.isEmpty()) {
            int currentFreq = pq.poll();

            while (currentFreq > 0 && usedFrequencies.contains(currentFreq)) {
                currentFreq--;
                deletions++;
            }

            if (currentFreq > 0) {
                usedFrequencies.add(currentFreq);
            }
        }

        return deletions;
    }
}