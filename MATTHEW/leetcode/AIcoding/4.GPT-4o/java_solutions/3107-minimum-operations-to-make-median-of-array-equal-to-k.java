class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        Arrays.sort(nums);
        int left = 0, right = n - 1, operations = 0;

        while (left <= right) {
            int median = nums[(left + right) / 2];
            if (median < k) {
                operations += k - median;
                left++;
            } else if (median > k) {
                operations += median - k;
                right--;
            } else {
                break;
            }
        }
        return operations;
    }
}