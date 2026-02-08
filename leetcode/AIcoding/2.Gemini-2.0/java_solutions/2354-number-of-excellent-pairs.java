class Solution {
    public long countExcellentPairs(int[] nums, int k) {
        boolean[] seen = new boolean[32001];
        int[] bitCounts = new int[32];
        for (int num : nums) {
            if (!seen[num]) {
                seen[num] = true;
                int count = Integer.bitCount(num);
                bitCounts[count]++;
            }
        }

        long result = 0;
        for (int i = 1; i < 32; i++) {
            if (bitCounts[i] > 0) {
                for (int j = 1; j < 32; j++) {
                    if (i + j >= k) {
                        result += (long) bitCounts[i] * bitCounts[j];
                    }
                }
            }
        }

        return result;
    }
}