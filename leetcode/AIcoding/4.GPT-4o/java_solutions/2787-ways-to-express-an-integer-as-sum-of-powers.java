public class Solution {
    public int countPowers(int n, int x) {
        if (n == 0) return 1;
        if (n < 0) return 0;
        int count = 0;
        for (int i = 1; Math.pow(i, x) <= n; i++) {
            count += countPowers(n - (int)Math.pow(i, x), x);
        }
        return count;
    }

    public int findSolutions(int n) {
        int count = 0;
        for (int x = 1; x <= 30; x++) {
            count += countPowers(n, x);
        }
        return count;
    }
}