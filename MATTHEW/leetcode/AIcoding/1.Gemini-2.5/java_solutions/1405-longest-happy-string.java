import java.util.PriorityQueue;

class Solution {
    public String longestDiverseString(int a, int b, int c) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((x, y) -> y[0] - x[0]);

        if (a > 0) {
            pq.add(new int[]{a, 0}); // 0 for 'a'
        }
        if (b > 0) {
            pq.add(new int[]{b, 1}); // 1 for 'b'
        }
        if (c > 0) {
            pq.add(new int[]{c, 2}); // 2 for 'c'
        }

        StringBuilder sb = new StringBuilder();

        while (!pq.isEmpty()) {
            int[] first = pq.poll(); // The character with the highest count
            char firstChar = (char) ('a' + first[1]);

            // Check if appending firstChar would create 'aaa', 'bbb', or 'ccc'
            if (sb.length() >= 2 && 
                sb.charAt(sb.length() - 1) == firstChar && 
                sb.charAt(sb.length() - 2) == firstChar) {

                // If so, we cannot use firstChar. Try to use the second highest.
                if (pq.isEmpty()) {
                    // No other character available, so we stop.
                    break; 
                }

                int[] second = pq.poll(); // The character with the second highest count
                char secondChar = (char) ('a' + second[1]);

                sb.append(secondChar);
                second[0]--;
                if (second[0] > 0) {
                    pq.add(second);
                }
                // Since firstChar was not used, put it back into the PQ.
                pq.add(first); 
            } else {
                // We can use firstChar.
                sb.append(firstChar);
                first[0]--;
                if (first[0] > 0) {
                    pq.add(first);
                }
            }
        }

        return sb.toString();
    }
}