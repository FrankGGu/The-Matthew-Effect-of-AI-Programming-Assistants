import java.util.HashSet;

public class Solution {
    public int distinctPrimeFactors(int[] nums) {
        HashSet<Integer> primeFactors = new HashSet<>();
        for (int num : nums) {
            for (int i = 2; i * i <= num; i++) {
                while (num % i == 0) {
                    primeFactors.add(i);
                    num /= i;
                }
            }
            if (num > 1) {
                primeFactors.add(num);
            }
        }
        return primeFactors.size();
    }
}