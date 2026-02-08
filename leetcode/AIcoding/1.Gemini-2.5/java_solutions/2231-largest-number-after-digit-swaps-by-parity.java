import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int largestNumber(int num) {
        char[] digits = String.valueOf(num).toCharArray();
        List<Integer> evenDigits = new ArrayList<>();
        List<Integer> oddDigits = new ArrayList<>();

        for (char c : digits) {
            int digit = Character.getNumericValue(c);
            if (digit % 2 == 0) {
                evenDigits.add(digit);
            } else {
                oddDigits.add(digit);
            }
        }

        Collections.sort(evenDigits, Collections.reverseOrder());
        Collections.sort(oddDigits, Collections.reverseOrder());

        StringBuilder resultBuilder = new StringBuilder();
        int evenIdx = 0;
        int oddIdx = 0;

        for (char c : digits) {
            int digit = Character.getNumericValue(c);
            if (digit % 2 == 0) {
                resultBuilder.append(evenDigits.get(evenIdx++));
            } else {
                resultBuilder.append(oddDigits.get(oddIdx++));
            }
        }

        return Integer.parseInt(resultBuilder.toString());
    }
}