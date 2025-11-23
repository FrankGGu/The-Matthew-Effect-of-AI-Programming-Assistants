class Solution {
    public int[] getGoodIndices(int[][] variables, int target) {
        List<Integer> goodIndices = new ArrayList<>();
        for (int i = 0; i < variables.length; i++) {
            int a = variables[i][0];
            int b = variables[i][1];
            int c = variables[i][2];
            int m = variables[i][3];

            long base = a;
            long exponent = b;
            long mod = 10;

            long firstMod = 1;
            while (exponent > 0) {
                if (exponent % 2 == 1) {
                    firstMod = (firstMod * base) % mod;
                }
                base = (base * base) % mod;
                exponent /= 2;
            }

            base = firstMod;
            exponent = c;
            mod = m;

            long secondMod = 1;
            while (exponent > 0) {
                if (exponent % 2 == 1) {
                    secondMod = (secondMod * base) % mod;
                }
                base = (base * base) % mod;
                exponent /= 2;
            }

            if (secondMod == target) {
                goodIndices.add(i);
            }
        }

        int[] result = new int[goodIndices.size()];
        for (int i = 0; i < goodIndices.size(); i++) {
            result[i] = goodIndices.get(i);
        }

        return result;
    }
}