import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numDifferentIntegers(String word) {
        Set<String> distinctIntegers = new HashSet<>();
        StringBuilder currentNumber = new StringBuilder();

        for (int i = 0; i < word.length(); i++) {
            char c = word.charAt(i);
            if (Character.isDigit(c)) {
                currentNumber.append(c);
            } else {
                if (currentNumber.length() > 0) {
                    String numStr = currentNumber.toString();
                    int firstDigit = 0;
                    while (firstDigit < numStr.length() - 1 && numStr.charAt(firstDigit) == '0') {
                        firstDigit++;
                    }
                    distinctIntegers.add(numStr.substring(firstDigit));
                    currentNumber.setLength(0);
                }
            }
        }

        if (currentNumber.length() > 0) {
            String numStr = currentNumber.toString();
            int firstDigit = 0;
            while (firstDigit < numStr.length() - 1 && numStr.charAt(firstDigit) == '0') {
                firstDigit++;
            }
            distinctIntegers.add(numStr.substring(firstDigit));
        }

        return distinctIntegers.size();
    }
}