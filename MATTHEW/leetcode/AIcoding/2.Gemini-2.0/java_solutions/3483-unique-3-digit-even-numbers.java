import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public int[] findEvenNumbers(int[] digits) {
        Set<Integer> result = new HashSet<>();
        Arrays.sort(digits);

        for (int i = 0; i < digits.length; i++) {
            if (digits[i] == 0) continue;
            for (int j = 0; j < digits.length; j++) {
                if (i == j) continue;
                for (int k = 0; k < digits.length; k++) {
                    if (i == k || j == k) continue;
                    if (digits[k] % 2 == 0) {
                        int num = digits[i] * 100 + digits[j] * 10 + digits[k];
                        result.add(num);
                    }
                }
            }
        }

        List<Integer> sortedResult = new ArrayList<>(result);
        sortedResult.sort(null);

        int[] resultArray = new int[sortedResult.size()];
        for (int i = 0; i < sortedResult.size(); i++) {
            resultArray[i] = sortedResult.get(i);
        }

        return resultArray;
    }
}