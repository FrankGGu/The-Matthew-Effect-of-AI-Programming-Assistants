import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public long smallestNumber(long num) {
        if (num == 0) {
            return 0;
        }
        boolean isNegative = num < 0;
        num = Math.abs(num);
        ArrayList<Integer> digits = new ArrayList<>();
        while (num > 0) {
            digits.add((int)(num % 10));
            num /= 10;
        }
        Collections.sort(digits);
        long result = 0;
        if (isNegative) {
            for (int i = digits.size() - 1; i >= 0; i--) {
                result = result * 10 + digits.get(i);
            }
            result = -result;
        } else {
            int firstNonZero = 0;
            while (firstNonZero < digits.size() && digits.get(firstNonZero) == 0) {
                firstNonZero++;
            }
            if (firstNonZero < digits.size()) {
                result = digits.get(firstNonZero);
                for (int i = 0; i < digits.size(); i++) {
                    if (i != firstNonZero) {
                        result = result * 10 + digits.get(i);
                    }
                }
            }
        }
        return result;
    }
}