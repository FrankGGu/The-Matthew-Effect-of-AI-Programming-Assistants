class Solution {
    public long waysToBuyPensPencils(int total, int cost1, int cost2) {
        long ways = 0;
        for (int i = 0; (long)i * cost1 <= total; i++) {
            int moneyLeft = total - i * cost1;
            ways += (moneyLeft / cost2) + 1;
        }
        return ways;
    }
}