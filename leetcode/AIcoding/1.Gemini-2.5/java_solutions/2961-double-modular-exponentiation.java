import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> getGoodIndices(int[][] variables, int target) {
        List<Integer> ans = new ArrayList<>();
        for (int i = 0; i < variables.length; i++) {
            int base = variables[i][0];
            int exp1 = variables[i][1];
            int mod2 = variables[i][2];
            int exp2 = variables[i][3];
            int mod = variables[i][4];

            long val1 = power(base, exp1, mod2);
            long finalResult = power(val1, exp2, mod);

            if (finalResult == target) {
                ans.add(i);
            }
        }
        return ans;
    }

    private long power(long base, long exp, long mod) {
        long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
}