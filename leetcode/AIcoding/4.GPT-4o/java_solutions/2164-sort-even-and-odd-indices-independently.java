class Solution {
    public int[] sortEvenOdd(int[] nums) {
        int n = nums.length;
        int[] even = new int[(n + 1) / 2];
        int[] odd = new int[n / 2];

        for (int i = 0, j = 0, k = 0; i < n; i++) {
            if (i % 2 == 0) {
                even[j++] = nums[i];
            } else {
                odd[k++] = nums[i];
            }
        }

        Arrays.sort(even);
        Arrays.sort(odd);

        for (int i = 0; i < odd.length; i++) {
            odd[i] = odd[odd.length - 1 - i];
        }

        for (int i = 0; i < even.length; i++) {
            nums[2 * i] = even[i];
        }

        for (int i = 0; i < odd.length; i++) {
            nums[2 * i + 1] = odd[i];
        }

        return nums;
    }
}