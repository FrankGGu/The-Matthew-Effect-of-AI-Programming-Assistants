public class Solution {

import java.util.*;

public class Solution {
    public int largestVariance(String s) {
        Set<Character> uniqueChars = new HashSet<>();
        for (char c : s.toCharArray()) {
            uniqueChars.add(c);
        }

        int maxVariance = 0;
        for (char a : uniqueChars) {
            for (char b : uniqueChars) {
                if (a == b) continue;
                int variance = 0;
                boolean hasB = false;
                for (char c : s.toCharArray()) {
                    if (c == a) variance++;
                    else if (c == b) {
                        hasB = true;
                        variance--;
                    }
                    if (variance < 0 && hasB) {
                        variance = 0;
                        hasB = false;
                    }
                }
                if (hasB) {
                    maxVariance = Math.max(maxVariance, variance);
                }
            }
        }
        return maxVariance;
    }
}
}