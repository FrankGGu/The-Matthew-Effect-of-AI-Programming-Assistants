public class Solution {

import java.util.*;

public class Solution {
    public String smallestSubstringWithIdenticalCharacters(String s) {
        Map<Character, Integer> charCount = new HashMap<>();
        int left = 0;
        int minLen = Integer.MAX_VALUE;
        String result = "";

        for (int right = 0; right < s.length(); right++) {
            char currentChar = s.charAt(right);
            charCount.put(currentChar, charCount.getOrDefault(currentChar, 0) + 1);

            while (charCount.size() == 1) {
                int currentLength = right - left + 1;
                if (currentLength < minLen) {
                    minLen = currentLength;
                    result = s.substring(left, right + 1);
                }
                char leftChar = s.charAt(left);
                charCount.put(leftChar, charCount.get(leftChar) - 1);
                if (charCount.get(leftChar) == 0) {
                    charCount.remove(leftChar);
                }
                left++;
            }
        }

        return result;
    }
}
}