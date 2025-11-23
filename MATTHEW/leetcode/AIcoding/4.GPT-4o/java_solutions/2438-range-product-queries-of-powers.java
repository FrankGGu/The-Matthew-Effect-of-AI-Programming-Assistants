class RangeProductQueries {
    private long[] prefixProduct;
    private static final int MOD = (int) 1e9 + 7;

    public RangeProductQueries(int[] powers) {
        prefixProduct = new long[powers.length + 1];
        for (int i = 0; i < powers.length; i++) {
            prefixProduct[i + 1] = (prefixProduct[i] * powers[i]) % MOD;
        }
    }

    public int[] productQueries(int n, int[][] queries) {
        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            long product = (prefixProduct[right + 1] * modInverse(prefixProduct[left], MOD)) % MOD;
            result[i] = (int) product;
        }
        return result;
    }

    private long modInverse(long a, int mod) {
        return pow(a, mod - 2, mod);
    }

    private long pow(long x, long y, int mod) {
        long res = 1;
        x = x % mod;
        while (y > 0) {
            if ((y & 1) == 1) {
                res = (res * x) % mod;
            }
            y = y >> 1;
            x = (x * x) % mod;
        }
        return res;
    }
}