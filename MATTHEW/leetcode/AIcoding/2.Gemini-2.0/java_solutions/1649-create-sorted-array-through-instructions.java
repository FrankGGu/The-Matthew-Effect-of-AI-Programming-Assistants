class Solution {
    private int[] bit;
    private int n;

    public int createSortedArray(int[] instructions) {
        n = 0;
        for (int x : instructions) {
            n = Math.max(n, x);
        }
        n++;
        bit = new int[n];
        long ans = 0;
        long mod = 1000000007;

        for (int i = 0; i < instructions.length; i++) {
            int x = instructions[i];
            int less = query(x - 1);
            int greater = i - query(x);
            ans = (ans + Math.min(less, greater)) % mod;
            update(x, 1);
        }

        return (int) ans;
    }

    private void update(int i, int val) {
        while (i < n) {
            bit[i] += val;
            i += i & -i;
        }
    }

    private int query(int i) {
        int sum = 0;
        while (i > 0) {
            sum += bit[i];
            i -= i & -i;
        }
        return sum;
    }
}