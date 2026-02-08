class Solution {
    public int minSpeedOnTime(double[] dist, double hour) {
        int left = 1, right = 10000000;
        int ans = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            double time = 0;
            for (int i = 0; i < dist.length - 1; i++) {
                time += Math.ceil(dist[i] / mid);
            }
            time += dist[dist.length - 1] / mid;
            if (time <= hour) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }
}