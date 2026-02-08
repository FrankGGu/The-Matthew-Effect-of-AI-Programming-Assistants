import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> findPrimePairs(int n) {
        boolean[] isPrime = new boolean[n + 1];
        for (int i = 2; i <= n; i++) {
            isPrime[i] = true;
        }

        for (int p = 2; p * p <= n; p++) {
            if (isPrime[p]) {
                for (int i = p * p; i <= n; i += p) {
                    isPrime[i] = false;
                }
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        for (int i = 2; i <= n / 2; i++) {
            if (isPrime[i] && isPrime[n - i]) {
                List<Integer> pair = new ArrayList<>();
                pair.add(i);
                pair.add(n - i);
                result.add(pair);
            }
        }

        return result;
    }
}