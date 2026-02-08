import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public String smallestDivisibleDigitProduct(int n) {
        if (n == 1) {
            return "1";
        }

        List<Integer> digits = new ArrayList<>();
        for (int d = 9; d >= 2; d--) {
            while (n % d == 0) {
                digits.add(d);
                n /= d;
            }
        }

        if (n > 1) {
            return "-1";
        }

        Collections.sort(digits);

        StringBuilder sb = new StringBuilder();
        for (int digit : digits) {
            sb.append(digit);
        }

        return sb.toString();
    }
}