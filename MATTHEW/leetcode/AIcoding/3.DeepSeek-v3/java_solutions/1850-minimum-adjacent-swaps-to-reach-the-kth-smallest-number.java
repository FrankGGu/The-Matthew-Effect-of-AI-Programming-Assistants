class Solution {
    public int getMinSwaps(String num, int k) {
        char[] original = num.toCharArray();
        char[] target = num.toCharArray();
        for (int i = 0; i < k; i++) {
            nextPermutation(target);
        }
        int swaps = 0;
        for (int i = 0; i < original.length; i++) {
            if (original[i] != target[i]) {
                int j = i + 1;
                while (j < original.length && original[j] != target[i]) {
                    j++;
                }
                while (j > i) {
                    swap(original, j - 1, j);
                    swaps++;
                    j--;
                }
            }
        }
        return swaps;
    }

    private void nextPermutation(char[] nums) {
        int i = nums.length - 2;
        while (i >= 0 && nums[i] >= nums[i + 1]) {
            i--;
        }
        if (i >= 0) {
            int j = nums.length - 1;
            while (j >= 0 && nums[j] <= nums[i]) {
                j--;
            }
            swap(nums, i, j);
        }
        reverse(nums, i + 1);
    }

    private void swap(char[] nums, int i, int j) {
        char temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }

    private void reverse(char[] nums, int start) {
        int i = start, j = nums.length - 1;
        while (i < j) {
            swap(nums, i, j);
            i++;
            j--;
        }
    }
}