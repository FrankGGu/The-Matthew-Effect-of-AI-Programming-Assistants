class Solution {
    public int[] productQueries(int n, int[][] queries) {
        List<Integer> powers = new ArrayList<>();
        int mod = 1_000_000_007;
        for (int i = 0; i < 32; i++) {
            if ((n & (1 << i)) != 0) {
                powers.add(1 << i);
            }
        }
        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            long product = 1;
            for (int j = left; j <= right; j++) {
                product = (product * powers.get(j)) % mod;
            }
            res[i] = (int) product;
        }
        return res;
    }
}