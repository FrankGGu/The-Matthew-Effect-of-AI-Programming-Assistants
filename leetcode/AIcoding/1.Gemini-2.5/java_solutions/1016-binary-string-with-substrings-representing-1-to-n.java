import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean queryString(String s, int n) {
        Set<Integer> foundNumbers = new HashSet<>();

        for (int i = 0; i < s.length(); i++) {
            for (int j = i; j < s.length(); j++) {
                String sub = s.substring(i, j + 1);

                // Binary representations for positive integers do not have leading zeros,
                // unless the number itself is 0, which is not in the range 1 to n.
                // Also, Integer.parseInt for radix 2 handles up to 31 bits for positive integers.
                // If a binary string is longer, it won't fit in a positive int.
                if (sub.length() > 31) { 
                    break; // Any further substrings starting at i will also be too long
                }

                if (sub.charAt(0) == '0' && sub.length() > 1) {
                    continue; // Skip invalid binary representations (e.g., "01" for 1)
                }

                int val = Integer.parseInt(sub, 2);

                // We only care about numbers up to n
                if (val >= 1 && val <= n) {
                    foundNumbers.add(val);
                }
            }
        }

        // Check if all numbers from 1 to n are found
        for (int k = 1; k <= n; k++) {
            if (!foundNumbers.contains(k)) {
                return false;
            }
        }

        return true;
    }
}