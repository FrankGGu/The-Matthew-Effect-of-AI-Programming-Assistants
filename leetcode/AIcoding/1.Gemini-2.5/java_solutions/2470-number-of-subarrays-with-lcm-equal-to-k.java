class Solution {
    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    public int subarrayLCM(int[] nums, int k) {
        int n = nums.length;
        int count = 0;

        for (int i = 0; i < n; i++) {
            int currentLCM = 1; 
            for (int j = i; j < n; j++) {
                // Optimization: If nums[j] is not a divisor of k, then the LCM of any subarray
                // containing nums[j] cannot be k. We can break the inner loop.
                if (k % nums[j] != 0) {
                    break;
                }

                // Calculate LCM of currentLCM and nums[j]
                // To prevent overflow and handle cases where LCM exceeds k
                long nextLCM = (long)currentLCM / gcd(currentLCM, nums[j]) * nums[j];

                if (nextLCM > k) {
                    // If LCM exceeds k, it can no longer be k.
                    // Mark currentLCM as too large and break.
                    currentLCM = k + 1; 
                } else {
                    currentLCM = (int)nextLCM;
                }

                if (currentLCM == k) {
                    count++;
                } else if (currentLCM > k) {
                    // If currentLCM became greater than k, then all subsequent subarrays starting at i
                    // will also have LCM > k. So we can break the inner loop.
                    break;
                }
            }
        }
        return count;
    }
}