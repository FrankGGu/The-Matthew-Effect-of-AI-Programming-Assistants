import java.util.HashSet;
import java.util.Set;

class Solution {
    public int distinctPrimeFactors(int[] nums) {
        Set<Integer> distinctFactors = new HashSet<>();

        for (int num : nums) {
            int n = num;
            for (int i = 2; i * i <= n; i++) {
                if (n % i == 0) {
                    distinctFactors.add(i);
                    while (n % i == 0) {
                        n /= i;
                    }
                }
            }
            if (n > 1) {
                distinctFactors.add(n);
            }
        }

        return distinctFactors.size();
    }
}