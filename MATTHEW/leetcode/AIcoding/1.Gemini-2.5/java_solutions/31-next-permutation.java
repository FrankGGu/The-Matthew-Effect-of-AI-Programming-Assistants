class Solution {
    public void nextPermutation(int[] nums) {
        int n = nums.length;
        int k = -1;

        // Step 1: Find the largest index k such that nums[k] < nums[k+1]
        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] < nums[i + 1]) {
                k = i;
                break;
            }
        }

        // If no such index exists, the array is in descending order,
        // so reverse the entire array to get the lowest possible order.
        if (k == -1) {
            reverse(nums, 0, n - 1);
            return;
        }

        // Step 2: Find the largest index l greater than k such that nums[k] < nums[l]
        int l = -1;
        for (int i = n - 1; i > k; i--) {
            if (nums[k] < nums[i]) {
                l = i;
                break;
            }
        }

        // Step 3: Swap nums[k] and nums[l]
        swap(nums, k, l);

        // Step 4: Reverse the sub-array nums[k+1:]
        reverse(nums, k + 1, n - 1);
    }

    private void swap(int[] nums, int i, int j) {
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }

    private void reverse(int[] nums, int start, int end) {
        while (start < end) {
            swap(nums, start, end);
            start++;
            end--;
        }
    }
}