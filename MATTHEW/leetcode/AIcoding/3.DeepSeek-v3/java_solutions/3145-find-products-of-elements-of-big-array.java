class Solution {
    public int[] productQueries(int n, int[][] queries) {
        List<Integer> powers = new ArrayList<>();
        for (int i = 0; i < 32; i++) {
            if ((n & (1 << i)) != 0) {
                powers.add(1 << i);
            }
        }

        int[] prefix = new int[powers.size() + 1];
        prefix[0] = 1;
        for (int i = 0; i < powers.size(); i++) {
            prefix[i + 1] = (int)((long)prefix[i] * powers.get(i) % 1_000_000_007);
        }

        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            res[i] = (int)((long)prefix[right + 1] * modInverse(prefix[left], 1_000_000_007) % 1_000_000_007);
        }
        return res;
    }

    private int modInverse(int a, int mod) {
        return power(a, mod - 2, mod);
    }

    private int power(int x, int y, int mod) {
        int res = 1;
        x %= mod;
        while (y > 0) {
            if ((y & 1) == 1) {
                res = (int)((long)res * x % mod);
            }
            y >>= 1;
            x = (int)((long)x * x % mod);
        }
        return res;
    }
}