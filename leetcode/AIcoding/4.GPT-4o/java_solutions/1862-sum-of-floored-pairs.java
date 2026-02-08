class Solution {
    public int sumOfFlooredPairs(int[] nums) {
        int maxNum = 0;
        for (int num : nums) {
            maxNum = Math.max(maxNum, num);
        }

        long[] count = new long[maxNum + 1];
        for (int num : nums) {
            count[num]++;
        }

        long[] sum = new long[maxNum + 1];
        for (int i = 1; i <= maxNum; i++) {
            for (int j = i; j <= maxNum; j += i) {
                sum[j] += count[i];
            }
        }

        long result = 0;
        for (int i = 1; i <= maxNum; i++) {
            result += sum[i] * i;
        }

        return (int)(result % 1_000_000_007);
    }
}