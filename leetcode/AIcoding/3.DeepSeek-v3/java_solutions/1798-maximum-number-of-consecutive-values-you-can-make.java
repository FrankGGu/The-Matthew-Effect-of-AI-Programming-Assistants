class Solution {
    public int getMaximumConsecutive(int[] coins) {
        Arrays.sort(coins);
        int max = 1;
        for (int coin : coins) {
            if (coin > max) {
                break;
            }
            max += coin;
        }
        return max;
    }
}