class Solution {
    public int findSmallestDivisor(int[] nums, int threshold) {
        int maxVal = 0;
        for (int num : nums) {
            if (num > maxVal) {
                maxVal = num;
            }
        }

        int low = 1;
        int high = maxVal;
        int ans = maxVal; 

        while (low <= high) {
            int mid = low + (high - low) / 2;

            long currentSum = 0;
            for (int num : nums) {
                currentSum += (num + mid - 1) / mid; 
            }

            if (currentSum <= threshold) {
                ans = mid;
                high = mid - 1; 
            } else {
                low = mid + 1; 
            }
        }
        return ans;
    }
}