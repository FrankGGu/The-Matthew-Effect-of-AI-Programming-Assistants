import java.util.HashSet;
import java.util.Set;

class Solution {
    public int longestValidSubstring(String word, String[] forbidden) {
        Set<String> forbiddenSet = new HashSet<>();
        for (String s : forbidden) {
            forbiddenSet.add(s);
        }

        int maxLength = 0;
        for (int i = 0; i < word.length(); i++) {
            for (int j = i; j < word.length(); j++) {
                String sub = word.substring(i, j + 1);
                boolean isValid = true;
                for (int k = i; k <= j; k++) {
                    for (int l = 1; l <= 10 && k + l <= j + 1; l++) {
                        String temp = word.substring(k, k + l);
                        if (forbiddenSet.contains(temp)) {
                            isValid = false;
                            break;
                        }
                    }
                    if (!isValid) {
                        break;
                    }
                }

                if (isValid) {
                    maxLength = Math.max(maxLength, sub.length());
                }
            }
        }

        return maxLength;
    }
}