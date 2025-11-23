public class Solution {
    public int shipWithinDays(int[] weights, int D) {
        int left = 0, right = 0;
        for (int weight : weights) {
            left = Math.max(left, weight);
            right += weight;
        }

        while (left < right) {
            int mid = (left + right) / 2;
            int days = 1, currentWeight = 0;
            for (int weight : weights) {
                if (currentWeight + weight > mid) {
                    days++;
                    currentWeight = 0;
                }
                currentWeight += weight;
            }
            if (days > D) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}