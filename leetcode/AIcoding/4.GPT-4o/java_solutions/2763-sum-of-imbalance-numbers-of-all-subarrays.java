class Solution {
    public long sumOfImbalanceNumbers(int[] nums) {
        long result = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            int[] count = new int[n + 1];
            int uniqueCount = 0;
            int imbalance = 0;

            for (int j = i; j < n; j++) {
                if (count[nums[j]] == 0) uniqueCount++;
                count[nums[j]]++;

                if (uniqueCount == 1) {
                    imbalance = 0;
                } else {
                    int min = Integer.MAX_VALUE, max = Integer.MIN_VALUE;
                    for (int k = 0; k <= n; k++) {
                        if (count[k] > 0) {
                            min = Math.min(min, k);
                            max = Math.max(max, k);
                        }
                    }
                    imbalance = max - min;
                }
                result += imbalance;
            }
        }

        return result;
    }
}