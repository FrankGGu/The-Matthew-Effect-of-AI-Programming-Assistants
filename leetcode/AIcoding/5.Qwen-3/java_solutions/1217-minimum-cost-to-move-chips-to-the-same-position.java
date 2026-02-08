public class Solution {
    public int minCostToMoveChips(int[] chips) {
        int even = 0;
        int odd = 0;
        for (int i : chips) {
            if (i % 2 == 0) {
                even++;
            } else {
                odd++;
            }
        }
        return Math.min(even, odd);
    }
}