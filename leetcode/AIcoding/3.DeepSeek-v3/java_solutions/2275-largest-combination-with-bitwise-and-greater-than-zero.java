class Solution {
    public int largestCombination(int[] candidates) {
        int max = 0;
        for (int i = 0; i < 32; i++) {
            int count = 0;
            for (int num : candidates) {
                if (((num >> i) & 1) == 1) {
                    count++;
                }
            }
            max = Math.max(max, count);
        }
        return max;
    }
}