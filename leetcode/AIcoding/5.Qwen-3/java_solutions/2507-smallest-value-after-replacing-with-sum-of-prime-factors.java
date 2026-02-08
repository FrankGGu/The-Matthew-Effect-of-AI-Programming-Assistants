public class Solution {

import java.util.*;

public class Solution {
    public int sumOfPrimeFactors(int n) {
        int sum = 0;
        for (int i = 2; i * i <= n; i++) {
            while (n % i == 0) {
                sum += i;
                n /= i;
            }
        }
        if (n > 1) {
            sum += n;
        }
        return sum;
    }

    public int smallestValue(int n) {
        Set<Integer> seen = new HashSet<>();
        while (true) {
            if (seen.contains(n)) {
                return n;
            }
            seen.add(n);
            int next = sumOfPrimeFactors(n);
            if (next == n) {
                return n;
            }
            n = next;
        }
    }
}
}