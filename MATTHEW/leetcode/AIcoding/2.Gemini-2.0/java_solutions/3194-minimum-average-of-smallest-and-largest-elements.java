class Solution {
    public double minimumAverage(int[] nums) {
        int n = nums.length;
        if (n <= 2) {
            double sum = 0;
            for (int num : nums) {
                sum += num;
            }
            return sum / n;
        }

        double minAvg = Double.MAX_VALUE;
        for (int i = 0; i < n - 1; i++) {
            for (int j = i + 1; j < n; j++) {
                int[] subarray = new int[j - i + 1];
                for (int k = i; k <= j; k++) {
                    subarray[k - i] = nums[k];
                }

                if (subarray.length < 2) continue;

                int minVal = subarray[0];
                int maxVal = subarray[0];
                for (int val : subarray) {
                    minVal = Math.min(minVal, val);
                    maxVal = Math.max(maxVal, val);
                }

                minAvg = Math.min(minAvg, (double)(minVal + maxVal) / 2);
            }
        }
        return minAvg;
    }
}