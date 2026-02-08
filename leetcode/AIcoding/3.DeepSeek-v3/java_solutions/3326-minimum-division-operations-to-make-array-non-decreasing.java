class Solution {
    public int minimumDivisionOperations(int[] nums) {
        int n = nums.length;
        int operations = 0;
        for (int i = 1; i < n; i++) {
            if (nums[i] > nums[i - 1]) {
                continue;
            }
            int maxDivisions = 0;
            int current = nums[i];
            int prev = nums[i - 1];
            while (current <= prev) {
                if (prev == 0) {
                    return -1;
                }
                prev = prev / 2;
                maxDivisions++;
            }
            operations += maxDivisions;
            nums[i - 1] = prev;
        }
        return operations;
    }
}