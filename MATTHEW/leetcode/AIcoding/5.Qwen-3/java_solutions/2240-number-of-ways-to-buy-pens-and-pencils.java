public class Solution {
    public long waysToBuyPensPencils(int total, int cost1, int cost2) {
        long count = 0;
        int remaining = total;
        while (remaining >= 0) {
            count++;
            remaining -= cost1;
        }
        remaining = total;
        while (remaining >= 0) {
            count++;
            remaining -= cost2;
        }
        return count;
    }
}