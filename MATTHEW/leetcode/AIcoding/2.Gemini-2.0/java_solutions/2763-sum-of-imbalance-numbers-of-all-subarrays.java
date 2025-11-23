class Solution {
    public int sumImbalanceNumbers(int[] nums) {
        int n = nums.length;
        int sum = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int[] sub = new int[j - i + 1];
                for (int k = i; k <= j; k++) {
                    sub[k - i] = nums[k];
                }
                Arrays.sort(sub);
                int imbalance = 0;
                for (int k = 1; k < sub.length; k++) {
                    if (sub[k] - sub[k - 1] > 1) {
                        imbalance++;
                    }
                }
                sum += imbalance;
            }
        }
        return sum;
    }
}