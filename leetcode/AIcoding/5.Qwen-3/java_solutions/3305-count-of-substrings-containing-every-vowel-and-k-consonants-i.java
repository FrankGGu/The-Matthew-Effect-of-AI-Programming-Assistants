public class Solution {

import java.util.*;

public class Solution {
    public int countOfSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));

        for (int i = 0; i <= n - k; i++) {
            String sub = s.substring(i, i + k);
            Map<Character, Integer> vowelCount = new HashMap<>();
            boolean valid = true;

            for (char c : sub.toCharArray()) {
                if (vowels.contains(c)) {
                    vowelCount.put(c, vowelCount.getOrDefault(c, 0) + 1);
                }
            }

            if (vowelCount.size() == 5) {
                count++;
            }
        }

        return count;
    }
}
}