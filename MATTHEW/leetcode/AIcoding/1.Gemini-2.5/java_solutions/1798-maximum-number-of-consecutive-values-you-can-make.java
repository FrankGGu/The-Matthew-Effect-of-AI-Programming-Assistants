import java.util.Arrays;

class Solution {
    public int getMaximumConsecutive(int[] coins) {
        Arrays.sort(coins);
        int reach = 0;

        for (int coin : coins) {
            if (coin <= reach + 1) {
                reach += coin;
            } else {
                break;
            }
        }
        return reach + 1;
    }
}