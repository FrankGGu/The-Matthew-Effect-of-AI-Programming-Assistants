class Solution {
    public int semiOrderedPermutation(int[] nums) {
        int n = nums.length;
        int firstPos = -1, lastPos = -1;

        for (int i = 0; i < n; i++) {
            if (nums[i] == 1) firstPos = i;
            if (nums[i] == n) lastPos = i;
        }

        int swaps = 0;
        if (firstPos > lastPos) {
            swaps = firstPos + (n - 1 - lastPos);
        } else {
            swaps = firstPos + (n - 1 - lastPos) - 1;
        }

        return swaps;
    }
}