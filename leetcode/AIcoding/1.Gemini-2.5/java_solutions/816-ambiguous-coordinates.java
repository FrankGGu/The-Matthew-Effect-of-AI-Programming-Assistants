import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> ambiguousCoordinates(String s) {
        List<String> result = new ArrayList<>();
        String digits = s.substring(1, s.length() - 1);
        int n = digits.length();

        for (int i = 1; i < n; i++) {
            String s1 = digits.substring(0, i);
            String s2 = digits.substring(i);

            List<String> validS1 = getValidNumbers(s1);
            List<String> validS2 = getValidNumbers(s2);

            for (String v1 : validS1) {
                for (String v2 : validS2) {
                    result.add("(" + v1 + ", " + v2 + ")");
                }
            }
        }
        return result;
    }

    private List<String> getValidNumbers(String s) {
        List<String> validNums = new ArrayList<>();
        int n = s.length();
        if (n == 0) {
            return validNums;
        }

        // Case 1: Integer form
        // A number is a valid integer if it's "0" or does not start with "0".
        if (s.equals("0") || s.charAt(0) != '0') {
            validNums.add(s);
        }

        // Case 2: Decimal form
        // Iterate through all possible positions for the decimal point.
        // The decimal point cannot be at the very beginning or very end.
        for (int i = 1; i < n; i++) {
            String left = s.substring(0, i);
            String right = s.substring(i);

            // Conditions for a valid decimal number "left.right":
            // 1. The integer part 'left' cannot start with '0' if it has more than one digit.
            //    (e.g., "01.2" is invalid, but "0.2" is valid).
            // 2. The fractional part 'right' cannot end with '0'.
            //    (e.g., "1.20" is invalid).
            boolean leftIsValid = (left.length() == 1 || left.charAt(0) != '0');
            boolean rightIsValid = (right.charAt(right.length() - 1) != '0');

            if (leftIsValid && rightIsValid) {
                validNums.add(left + "." + right);
            }
        }
        return validNums;
    }
}