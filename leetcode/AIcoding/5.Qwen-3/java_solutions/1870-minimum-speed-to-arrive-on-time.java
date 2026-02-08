public class Solution {
    public int minSpeedToArriveOnTime(int[] dist, int hour) {
        int left = 1;
        int right = 100000000;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canReachOnTime(dist, mid, hour)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }

    private boolean canReachOnTime(int[] dist, int speed, double hour) {
        double time = 0.0;
        for (int i = 0; i < dist.length - 1; i++) {
            time += Math.ceil((double) dist[i] / speed);
        }
        time += (double) dist[dist.length - 1] / speed;
        return time <= hour;
    }
}