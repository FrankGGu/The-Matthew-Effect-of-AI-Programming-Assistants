class Solution {
    public int rangeSum(int[] nums, int n, int left, int right) {
        int[] subarraySums = new int[n * (n + 1) / 2];
        int index = 0;
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n; j++) {
                sum += nums[j];
                subarraySums[index++] = sum;
            }
        }
        Arrays.sort(subarraySums);
        long result = 0;
        for (int i = left - 1; i < right; i++) {
            result += subarraySums[i];
        }
        return (int) (result % 1000000007);
    }
}