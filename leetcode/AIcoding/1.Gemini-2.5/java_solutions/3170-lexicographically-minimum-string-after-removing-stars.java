import java.util.PriorityQueue;
import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public String removeStars(String s) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return b[0] - a[0];
            }
            return a[1] - b[1];
        });

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '*') {
                if (!pq.isEmpty()) {
                    pq.poll();
                }
            } else {
                pq.offer(new int[]{c, i});
            }
        }

        ArrayList<int[]> remainingChars = new ArrayList<>(pq);
        Collections.sort(remainingChars, (a, b) -> a[1] - b[1]);

        StringBuilder sb = new StringBuilder();
        for (int[] charInfo : remainingChars) {
            sb.append((char) charInfo[0]);
        }

        return sb.toString();
    }
}