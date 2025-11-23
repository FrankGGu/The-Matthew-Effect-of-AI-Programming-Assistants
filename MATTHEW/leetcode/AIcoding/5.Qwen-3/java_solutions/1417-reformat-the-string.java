public class Solution {

import java.util.*;

public class Solution {
    public String reformat(String s) {
        List<Character> letters = new ArrayList<>();
        List<Character> digits = new ArrayList<>();

        for (char c : s.toCharArray()) {
            if (Character.isLetter(c)) {
                letters.add(c);
            } else {
                digits.add(c);
            }
        }

        if (Math.abs(letters.size() - digits.size()) > 1) {
            return "";
        }

        StringBuilder result = new StringBuilder();
        int i = 0, j = 0;

        if (letters.size() > digits.size()) {
            while (i < letters.size() || j < digits.size()) {
                result.append(letters.get(i++));
                if (j < digits.size()) {
                    result.append(digits.get(j++));
                }
            }
        } else {
            while (i < letters.size() || j < digits.size()) {
                result.append(digits.get(j++));
                if (i < letters.size()) {
                    result.append(letters.get(i++));
                }
            }
        }

        return result.toString();
    }
}
}