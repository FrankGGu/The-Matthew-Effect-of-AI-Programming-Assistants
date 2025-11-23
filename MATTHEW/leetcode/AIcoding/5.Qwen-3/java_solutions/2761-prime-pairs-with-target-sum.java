public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> primePairsWithTargetSum(int n) {
        boolean[] isPrime = new boolean[n + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
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
}