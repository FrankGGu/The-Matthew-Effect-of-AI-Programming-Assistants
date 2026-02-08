import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public long smallestDivisibleDigitProduct(int n) {
        if (n == 1) {
            return 1;
        }

        List<Integer> digits = new ArrayList<>();
        // Iterate from 9 down to 2 to prioritize larger digits.
        // Using larger digits first helps to reduce the total number of digits,
        // which is crucial for finding the smallest number.
        for (int d = 9; d >= 2; d--) {
            while (n % d == 0) {
                digits.add(d);
                n /= d;
            }
        }

        // If n is still greater than 1, it means n has a prime factor greater than 9,
        // or n itself is a prime greater than 9.
        // In this case, it's impossible to form n using single digits (2-9).
        if (n > 1) {
            return -1;
        }

        // To form the smallest number, the collected digits must be arranged
        // in ascending order.
        Collections.sort(digits);

        long result = 0;
        for (int digit : digits) {
            // Check for potential overflow before constructing the number.
            // If 'result' is already greater than Long.MAX_VALUE / 10,
            // then 'result * 10' will definitely overflow.
            // If 'result' is equal to Long.MAX_VALUE / 10, then 'result * 10'
            // will be Long.MAX_VALUE - (Long.MAX_VALUE % 10).
            // Adding 'digit' might cause an overflow if 'digit' is too large.
            if (result > Long.MAX_VALUE / 10 || (result == Long.MAX_VALUE / 10 && digit > Long.MAX_VALUE % 10)) {
                return -1; // Overflow detected, no such 'long' integer exists.
            }
            result = result * 10 + digit;
        }

        return result;
    }
}