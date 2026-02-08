import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int[] addNegabinary(int[] arr1, int[] arr2) {
        List<Integer> result = new ArrayList<>();
        int i = arr1.length - 1;
        int j = arr2.length - 1;
        int carry = 0;

        while (i >= 0 || j >= 0 || carry != 0) {
            int val1 = (i >= 0) ? arr1[i] : 0;
            int val2 = (j >= 0) ? arr2[j] : 0;

            int sum = val1 + val2 + carry;

            // Negabinary addition rules:
            // For a sum 'S', we want to find a digit 'd' (0 or 1) and a new carry 'c'
            // such that S = d + c * (-2).
            // This can be derived as:
            // d = S % 2; if d < 0, d += 2; (to ensure d is 0 or 1)
            // c = (S - d) / (-2);

            int digit = sum % 2;
            if (digit < 0) { 
                digit += 2; 
            }
            carry = (sum - digit) / (-2);

            result.add(digit);

            i--;
            j--;
        }

        // Remove leading zeros, unless the result is just "0"
        // The result list is built from least significant to most significant digit.
        // So, result.get(result.size() - 1) is the most significant digit.
        while (result.size() > 1 && result.get(result.size() - 1) == 0) {
            result.remove(result.size() - 1);
        }

        // The result was built in reverse order (least significant first), so reverse it
        Collections.reverse(result);

        // Convert List<Integer> to int[]
        int[] finalResult = new int[result.size()];
        for (int k = 0; k < result.size(); k++) {
            finalResult[k] = result.get(k);
        }

        return finalResult;
    }
}