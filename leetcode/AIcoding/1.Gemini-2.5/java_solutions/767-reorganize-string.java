import java.util.PriorityQueue;

class Solution {
    public String reorganizeString(String S) {
        if (S == null || S.length() == 0) {
            return "";
        }

        int[] counts = new int[26];
        for (char c : S.toCharArray()) {
            counts[c - 'a']++;
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[1] - a[1]);

        for (int i = 0; i < 26; i++) {
            if (counts[i] > 0) {
                if (counts[i] > (S.length() + 1) / 2) {
                    return "";
                }
                pq.add(new int[]{i, counts[i]});
            }
        }

        StringBuilder result = new StringBuilder();

        while (pq.size() >= 2) {
            int[] entry1 = pq.poll();
            int[] entry2 = pq.poll();

            result.append((char) ('a' + entry1[0]));
            result.append((char) ('a' + entry2[0]));

            entry1[1]--;
            entry2[1]--;

            if (entry1[1] > 0) {
                pq.add(entry1);
            }
            if (entry2[1] > 0) {
                pq.add(entry2);
            }
        }

        if (!pq.isEmpty()) {
            int[] lastEntry = pq.poll();
            if (lastEntry[1] > 1) { 
                return "";
            }
            result.append((char) ('a' + lastEntry[0]));
        }

        return result.toString();
    }
}