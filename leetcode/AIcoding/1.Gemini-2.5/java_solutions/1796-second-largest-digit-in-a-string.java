import java.util.Set;
import java.util.TreeSet;
import java.util.List;
import java.util.ArrayList;
import java.util.Collections;

class Solution {
    public int secondLargestDigit(String s) {
        Set<Integer> digits = new TreeSet<>();
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                digits.add(Character.getNumericValue(c));
            }
        }

        if (digits.size() < 2) {
            return -1;
        }

        List<Integer> sortedDigits = new ArrayList<>(digits);
        Collections.sort(sortedDigits);

        return sortedDigits.get(sortedDigits.size() - 2);
    }
}