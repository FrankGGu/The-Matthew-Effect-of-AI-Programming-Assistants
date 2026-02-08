public class Solution {
    public int trafficLight(int n, int[][] cars) {
        int[] light = new int[4];
        for (int i = 0; i < n; i++) {
            int direction = cars[i][0];
            int turn = cars[i][1];
            if (turn == 0) {
                light[direction] = 1;
            } else {
                light[direction] = 2;
            }
        }
        int max = 0;
        for (int i = 0; i < 4; i++) {
            if (light[i] > max) {
                max = light[i];
            }
        }
        return max;
    }
}