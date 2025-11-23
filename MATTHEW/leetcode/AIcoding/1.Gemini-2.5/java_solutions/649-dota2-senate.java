import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public String predictPartyVictory(String senate) {
        int n = senate.length();
        Queue<Integer> radiantQueue = new LinkedList<>();
        Queue<Integer> direQueue = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            if (senate.charAt(i) == 'R') {
                radiantQueue.offer(i);
            } else {
                direQueue.offer(i);
            }
        }

        while (!radiantQueue.isEmpty() && !direQueue.isEmpty()) {
            int rIndex = radiantQueue.poll();
            int dIndex = direQueue.poll();

            if (rIndex < dIndex) {
                radiantQueue.offer(rIndex + n);
            } else {
                direQueue.offer(dIndex + n);
            }
        }

        return radiantQueue.isEmpty() ? "Dire" : "Radiant";
    }
}