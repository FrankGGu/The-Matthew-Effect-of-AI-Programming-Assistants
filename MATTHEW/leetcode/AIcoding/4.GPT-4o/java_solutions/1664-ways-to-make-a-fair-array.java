class Solution {
    public int waysToMakeFair(int[] nums) {
        int n = nums.length;
        int[] prefixOdd = new int[n + 1];
        int[] prefixEven = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefixOdd[i + 1] = prefixOdd[i] + (i % 2 == 1 ? nums[i] : 0);
            prefixEven[i + 1] = prefixEven[i] + (i % 2 == 0 ? nums[i] : 0);
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            int oddSum = prefixOdd[i] + (prefixEven[n] - prefixEven[i + 1]);
            int evenSum = prefixEven[i] + (prefixOdd[n] - prefixOdd[i + 1]);
            if (oddSum == evenSum) {
                count++;
            }
        }

        return count;
    }
}