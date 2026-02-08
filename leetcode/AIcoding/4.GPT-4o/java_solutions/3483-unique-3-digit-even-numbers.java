import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int countEven(int[] digits) {
        Set<Integer> uniqueNumbers = new HashSet<>();
        for (int i = 0; i < digits.length; i++) {
            for (int j = 0; j < digits.length; j++) {
                if (j == i) continue;
                for (int k = 0; k < digits.length; k++) {
                    if (k == i || k == j) continue;
                    if (digits[k] % 2 == 0) {
                        uniqueNumbers.add(digits[i] * 100 + digits[j] * 10 + digits[k]);
                    }
                }
            }
        }
        return uniqueNumbers.size();
    }
}