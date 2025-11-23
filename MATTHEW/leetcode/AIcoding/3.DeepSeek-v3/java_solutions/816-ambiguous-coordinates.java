import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> ambiguousCoordinates(String s) {
        List<String> result = new ArrayList<>();
        String numStr = s.substring(1, s.length() - 1);
        for (int i = 1; i < numStr.length(); i++) {
            String left = numStr.substring(0, i);
            String right = numStr.substring(i);
            List<String> leftNums = generateNumbers(left);
            List<String> rightNums = generateNumbers(right);
            for (String l : leftNums) {
                for (String r : rightNums) {
                    result.add("(" + l + ", " + r + ")");
                }
            }
        }
        return result;
    }

    private List<String> generateNumbers(String s) {
        List<String> numbers = new ArrayList<>();
        if (s.length() == 1) {
            numbers.add(s);
            return numbers;
        }
        if (s.charAt(0) == '0') {
            if (s.charAt(s.length() - 1) == '0') {
                return numbers;
            }
            numbers.add("0." + s.substring(1));
            return numbers;
        }
        if (s.charAt(s.length() - 1) == '0') {
            numbers.add(s);
            return numbers;
        }
        numbers.add(s);
        for (int i = 1; i < s.length(); i++) {
            numbers.add(s.substring(0, i) + "." + s.substring(i));
        }
        return numbers;
    }
}