import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public int[] findEvenNumbers(int[] digits) {
        Set<Integer> result = new HashSet<>();
        int n = digits.length;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) continue;
                for (int k = 0; k < n; k++) {
                    if (i == k || j == k) continue;
                    int num = digits[i] * 100 + digits[j] * 10 + digits[k];
                    if (num >= 100 && num % 2 == 0 && digits[i] != 0) {
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