import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numDifferentIntegers(String word) {
        Set<String> set = new HashSet<>();
        int n = word.length();
        int i = 0;
        while (i < n) {
            if (Character.isDigit(word.charAt(i))) {
                int j = i;
                while (j < n && Character.isDigit(word.charAt(j))) {
                    j++;
                }
                String numStr = word.substring(i, j);
                // Remove leading zeros
                int k = 0;
                while (k < numStr.length() - 1 && numStr.charAt(k) == '0') {
                    k++;
                }
                numStr = numStr.substring(k);
                set.add(numStr);
                i = j;
            } else {
                i++;
            }
        }
        return set.size();
    }
}