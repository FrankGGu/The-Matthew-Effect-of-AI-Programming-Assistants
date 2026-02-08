class Solution {
    public int nthUglyNumber(int n) {
        int[] ugly = new int[n];
        ugly[0] = 1;
        int p2 = 0, p3 = 0, p5 = 0;
        for (int i = 1; i < n; i++) {
            int next2 = ugly[p2] * 2;
            int next3 = ugly[p3] * 3;
            int next5 = ugly[p5] * 5;
            ugly[i] = Math.min(next2, Math.min(next3, next5));
            if (ugly[i] == next2) p2++;
            if (ugly[i] == next3) p3++;
            if (ugly[i] == next5) p5++;
        }
        return ugly[n - 1];
    }
}