import java.util.ArrayList;
import java.util.List;

public class Solution {
    public int smallestValue(int n) {
        while (true) {
            int sum = sumOfPrimeFactors(n);
            if (sum == n) break;
            n = sum;
        }
        return n;
    }

    private int sumOfPrimeFactors(int n) {
        List<Integer> primeFactors = new ArrayList<>();
        for (int i = 2; i * i <= n; i++) {
            while (n % i == 0) {
                primeFactors.add(i);
                n /= i;
            }
        }
        if (n > 1) primeFactors.add(n);
        return primeFactors.stream().mapToInt(Integer::intValue).sum();
    }
}