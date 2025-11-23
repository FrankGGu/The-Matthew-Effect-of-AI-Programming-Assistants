class Solution {
    public int maxSumDivisibleByK(int[] nums, int k) {
        int n = nums.length;
        int[] remainders = new int[k];
        remainders[0] = 0;
        for (int i = 1; i < k; i++) {
            remainders[i] = Integer.MIN_VALUE;
        }

        int sum = 0;
        for (int num : nums) {
            sum += num;
            int remainder = (sum % k + k) % k;
            int[] tempRemainders = new int[k];
            for (int i = 0; i < k; i++) {
                tempRemainders[i] = remainders[i];
            }

            tempRemainders[remainder] = Math.max(tempRemainders[remainder], sum);
            for (int i = 0; i < k; i++) {
                if (remainders[i] != Integer.MIN_VALUE) {
                    int newRemainder = (remainder - i + k) % k;
                    tempRemainders[remainder] = Math.max(tempRemainders[remainder], remainders[i] + num);
                }
            }

            remainders = tempRemainders;
        }

        return remainders[0] == Integer.MIN_VALUE ? 0 : remainders[0];
    }
}