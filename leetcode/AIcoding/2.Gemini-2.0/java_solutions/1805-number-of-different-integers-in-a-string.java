import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numDifferentIntegers(String word) {
        Set<String> numbers = new HashSet<>();
        StringBuilder sb = new StringBuilder();
        for (char c : word.toCharArray()) {
            if (Character.isDigit(c)) {
                sb.append(c);
            } else {
                if (sb.length() > 0) {
                    String num = sb.toString();
                    int i = 0;
                    while (i < num.length() - 1 && num.charAt(i) == '0') {
                        i++;
                    }
                    numbers.add(num.substring(i));
                    sb = new StringBuilder();
                }
            }
        }
        if (sb.length() > 0) {
            String num = sb.toString();
            int i = 0;
            while (i < num.length() - 1 && num.charAt(i) == '0') {
                i++;
            }
            numbers.add(num.substring(i));
        }
        return numbers.size();
    }
}