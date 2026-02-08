class Solution {

    private void nextPermutation(char[] nums) {
        int n = nums.length;
        int i = n - 2;
        while (i >= 0 && nums[i] >= nums[i + 1]) {
            i--;
        }

        if (i >= 0) {
            int j = n - 1;
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
        int i = start;
        int j = nums.length - 1;
        while (i < j) {
            swap(nums, i, j);
            i++;
            j--;
        }
    }

    private int minSwaps(char[] original, char[] target) {
        int n = original.length;
        int swaps = 0;

        char[] current = new char[n];
        System.arraycopy(original, 0, current, 0, n);

        for (int i = 0; i < n; i++) {
            if (current[i] != target[i]) {
                int j = i + 1;
                while (j < n && current[j] != target[i]) {
                    j++;
                }

                for (int k = j; k > i; k--) {
                    swap(current, k, k - 1);
                    swaps++;
                }
            }
        }
        return swaps;
    }

    public int getMinSwaps(String num, int k) {
        char[] originalArr = num.toCharArray();
        char[] targetArr = num.toCharArray();

        for (int i = 0; i < k; i++) {
            nextPermutation(targetArr);
        }

        return minSwaps(originalArr, targetArr);
    }
}