class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int countOnes = 0;
        for (int num : nums) {
            if (num == 1) countOnes++;
        }

        if (countOnes == n) return 0;

        int minOps = n;
        int currentOnes = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] == 1) currentOnes++;
            if (i >= countOnes) {
                if (nums[i - countOnes] == 1) currentOnes--;
            }
            if (i >= countOnes - 1) {
                minOps = Math.min(minOps, countOnes - currentOnes);
            }
        }
        return minOps;
    }
}