import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numDifferentIntegers(String word) {
        String s = word.replaceAll("[a-z]", " ");
        String[] parts = s.split("\\s+");
        Set<String> uniqueIntegers = new HashSet<>();

        for (String part : parts) {
            if (part.isEmpty()) {
                continue;
            }

            int i = 0;
            while (i < part.length() - 1 && part.charAt(i) == '0') {
                i++;
            }
            uniqueIntegers.add(part.substring(i));
        }

        return uniqueIntegers.size();
    }
}