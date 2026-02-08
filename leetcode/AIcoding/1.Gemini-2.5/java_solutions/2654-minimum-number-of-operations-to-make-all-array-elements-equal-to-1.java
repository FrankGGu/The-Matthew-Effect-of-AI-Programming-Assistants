class Solution {
    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    public int minOperations(int[] nums) {
        int n = nums.length;
        int onesCount = 0;
        for (int num : nums) {
            if (num == 1) {
                onesCount++;
            }
        }

        if (onesCount > 0) {
            return n - onesCount;
        }

        int minOpsToCreateOne = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            int currentGcd = nums[i];
            for (int j = i + 1; j < n; j++) {
                currentGcd = gcd(currentGcd, nums[j]);
                if (currentGcd == 1) {
                    // The subarray nums[i...j] has a GCD of 1.
                    // The length of this subarray is (j - i + 1).
                    // It takes (j - i) operations to reduce this subarray to a single '1'.
                    // For example, [a, b, c] (length 3).
                    // 1. Replace b with gcd(a,b) -> [a, gcd(a,b), c] or [gcd(a,b), c] if we consider it merging.
                    // More accurately, to get gcd(a,b,c) at one position:
                    // gcd(a,b) (1 op)
                    // gcd(result_of_ab, c) (1 op)
                    // Total (length - 1) operations.
                    minOpsToCreateOne = Math.min(minOpsToCreateOne, j - i);
                    break; // Found the shortest subarray starting at 'i' that yields 1.
                }
            }
        }

        if (minOpsToCreateOne == Integer.MAX_VALUE) {
            // No subarray could produce a GCD of 1, so it's impossible.
            return -1;
        } else {
            // We need 'minOpsToCreateOne' operations to create the first '1'.
            // After that, we have one '1' in the array.
            // We need 'n - 1' additional operations to propagate this '1' to all other 'n - 1' elements.
            return minOpsToCreateOne + (n - 1);
        }
    }
}