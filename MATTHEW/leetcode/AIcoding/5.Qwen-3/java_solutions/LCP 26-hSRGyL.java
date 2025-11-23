public class Solution {
    public int[] navigateDevices(int[][] devices) {
        int n = devices.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            int x = devices[i][0];
            int y = devices[i][1];
            int steps = 0;
            while (x != 0 || y != 0) {
                if (x > 0) {
                    x--;
                } else if (x < 0) {
                    x++;
                }
                if (y > 0) {
                    y--;
                } else if (y < 0) {
                    y++;
                }
                steps++;
            }
            result[i] = steps;
        }
        return result;
    }
}