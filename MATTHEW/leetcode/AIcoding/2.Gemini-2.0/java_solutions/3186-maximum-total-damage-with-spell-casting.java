import java.util.Arrays;

class Solution {
    public int maximumTotalDamage(int[] damage, int[] cost, long armor) {
        int n = damage.length;
        int totalDamage = 0;
        int maxDamage = 0;
        for (int d : damage) {
            totalDamage += d;
            maxDamage = Math.max(maxDamage, d);
        }

        long reduce = Math.min(armor, maxDamage);

        return totalDamage - (int)reduce;
    }
}