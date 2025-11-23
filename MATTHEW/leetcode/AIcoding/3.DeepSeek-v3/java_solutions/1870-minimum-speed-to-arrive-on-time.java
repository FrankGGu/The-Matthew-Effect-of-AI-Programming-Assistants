class Solution {
    public int minSpeedOnTime(int[] dist, double hour) {
        int left = 1;
        int right = 10000000;
        int result = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            double total = 0.0;
            for (int i = 0; i < dist.length; i++) {
                if (i != dist.length - 1) {
                    total += Math.ceil((double) dist[i] / mid);
                } else {
                    total += (double) dist[i] / mid;
                }
            }
            if (total <= hour) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return result;
    }
}