class Solution {
    public long waysToBuyPensPencils(int total, int cost1, int cost2) {
        long ways = 0;
        for (int i = 0; i * cost1 <= total; i++) {
            int remaining = total - i * cost1;
            ways += (remaining / cost2) + 1;
        }
        return ways;
    }
}