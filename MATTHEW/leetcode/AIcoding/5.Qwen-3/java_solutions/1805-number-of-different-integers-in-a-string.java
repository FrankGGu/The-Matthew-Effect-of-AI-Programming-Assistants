public class Solution {

import java.util.HashSet;
import java.util.Set;

public class Solution {
    public int numberOfDifferentIntegers(String word) {
        Set<String> set = new HashSet<>();
        StringBuilder num = new StringBuilder();
        boolean isDigit = false;

        for (char c : word.toCharArray()) {
            if (Character.isDigit(c)) {
                num.append(c);
                isDigit = true;
            } else {
                if (isDigit) {
                    set.add(num.toString());
                    num = new StringBuilder();
                    isDigit = false;
                }
            }
        }

        if (isDigit) {
            set.add(num.toString());
        }

        return set.size();
    }
}
}