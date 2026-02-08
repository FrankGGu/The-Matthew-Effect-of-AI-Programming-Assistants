class Solution {
    public int[] getGoodIndices(int[][] variables, int target) {
        List<Integer> res = new ArrayList<>();
        for (int i = 0; i < variables.length; i++) {
            int a = variables[i][0];
            int b = variables[i][1];
            int c = variables[i][2];
            int m = variables[i][3];

            int pow1 = powMod(a, b, 10);
            int pow2 = powMod(pow1, c, m);

            if (pow2 == target) {
                res.add(i);
            }
        }
        return res.stream().mapToInt(i -> i).toArray();
    }

    private int powMod(int base, int exponent, int mod) {
        if (mod == 1) return 0;
        int result = 1;
        base = base % mod;
        while (exponent > 0) {
            if (exponent % 2 == 1) {
                result = (result * base) % mod;
            }
            exponent = exponent >> 1;
            base = (base * base) % mod;
        }
        return result;
    }
}