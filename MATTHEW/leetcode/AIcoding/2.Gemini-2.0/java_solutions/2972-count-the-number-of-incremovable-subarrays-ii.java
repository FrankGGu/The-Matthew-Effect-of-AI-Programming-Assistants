class Solution {
    public long countSubarrays(int[] nums) {
        int n = nums.length;
        long count = 0;
        for (int i = 0; i <= n; i++) {
            for (int j = i; j <= n; j++) {
                int[] temp = new int[n - (j - i)];
                int k = 0;
                for (int l = 0; l < n; l++) {
                    if (l < i || l >= j) {
                        temp[k++] = nums[l];
                    }
                }

                if (temp.length == 0 || isIncreasing(temp)) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isIncreasing(int[] arr) {
        for (int i = 1; i < arr.length; i++) {
            if (arr[i] <= arr[i - 1]) {
                return false;
            }
        }
        return true;
    }
}