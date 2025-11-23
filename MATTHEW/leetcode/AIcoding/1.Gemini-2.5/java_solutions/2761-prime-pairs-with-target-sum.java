import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<Integer> findPrimePairs(int n) {
        boolean[] isPrime = new boolean[n + 1];
        Arrays.fill(isPrime, true);
        if (n >= 0) isPrime[0] = false;
        if (n >= 1) isPrime[1] = false;

        for (int p = 2; p * p <= n; p++) {
            if (isPrime[p]) {
                for (int multiple = p * p; multiple <= n; multiple += p)
                    isPrime[multiple] = false;
            }
        }

        for (int a = 2; a <= n / 2; a++) {
            if (isPrime[a]) {
                int b = n - a;
                if (isPrime[b]) {
                    return Arrays.asList(a, b);
                }
            }
        }

        return Arrays.asList(-1, -1);
    }
}