public class Solution {

import java.util.*;

public class Solution {
    public int findTheNumberofUniqueDigits() {
        Set<Integer> uniqueNumbers = new HashSet<>();
        for (int i = 100; i <= 999; i++) {
            if (i % 2 == 0) {
                String s = String.valueOf(i);
                if (s.charAt(0) != s.charAt(1) && s.charAt(0) != s.charAt(2) && s.charAt(1) != s.charAt(2)) {
                    uniqueNumbers.add(i);
                }
            }
        }
        return uniqueNumbers.size();
    }
}
}