class Solution {
    public int dynamicPassword(int n, int m, int[] key) {
        int[] nums = new int[n];
        for (int i = 0; i < n; i++) {
            nums[i] = i + 1;
        }

        for (int k : key) {
            k %= n;
            int[] temp = new int[n];
            for (int i = 0; i < k; i++) {
                temp[i] = nums[n - k + i];
            }
            for (int i = k; i < n; i++) {
                temp[i] = nums[i - k];
            }
            nums = temp;
        }

        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        return sum % m;
    }
}