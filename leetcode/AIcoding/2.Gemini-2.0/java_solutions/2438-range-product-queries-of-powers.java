class Solution {
    public int[] productQueries(int n, int[][] queries) {
        List<Integer> powers = new ArrayList<>();
        for (int i = 0; i <= 30; i++) {
            if ((n & (1 << i)) != 0) {
                powers.add((int) Math.pow(2, i));
            }
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int left = queries[i][0];
            int right = queries[i][1];
            long product = 1;
            for (int j = left; j <= right; j++) {
                product = (product * powers.get(j)) % 1000000007;
            }
            result[i] = (int) product;
        }
        return result;
    }
}