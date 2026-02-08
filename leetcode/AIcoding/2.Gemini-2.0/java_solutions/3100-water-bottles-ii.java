import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

class Solution {
    public int maxBottles(int capA, int capB, int target) {
        Queue<int[]> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(new int[]{0, 0});
        visited.add("0,0");
        int max = 0;

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int a = curr[0];
            int b = curr[1];
            max = Math.max(max, a + b);

            // Fill A
            if (a < capA) {
                if (visited.add(capA + "," + b)) {
                    queue.offer(new int[]{capA, b});
                }
            }

            // Fill B
            if (b < capB) {
                if (visited.add(a + "," + capB)) {
                    queue.offer(new int[]{a, capB});
                }
            }

            // Empty A
            if (a > 0) {
                if (visited.add("0," + b)) {
                    queue.offer(new int[]{0, b});
                }
            }

            // Empty B
            if (b > 0) {
                if (visited.add(a + ",0")) {
                    queue.offer(new int[]{a, 0});
                }
            }

            // Pour A to B
            int pour = Math.min(a, capB - b);
            if (pour > 0) {
                if (visited.add((a - pour) + "," + (b + pour))) {
                    queue.offer(new int[]{a - pour, b + pour});
                }
            }

            // Pour B to A
            pour = Math.min(b, capA - a);
            if (pour > 0) {
                if (visited.add((a + pour) + "," + (b - pour))) {
                    queue.offer(new int[]{a + pour, b - pour});
                }
            }
        }
        return Math.min(max, target);
    }
}