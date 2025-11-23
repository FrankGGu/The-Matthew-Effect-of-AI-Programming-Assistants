public class Solution {

import java.util.*;

public class Solution {
    public int[] distinctDifferenceArray(String s) {
        int n = s.length();
        int[] result = new int[n];

        for (int i = 0; i < n; i++) {
            Set<Character> leftSet = new HashSet<>();
            for (int j = 0; j <= i; j++) {
                leftSet.add(s.charAt(j));
            }

            Set<Character> rightSet = new HashSet<>();
            for (int j = i + 1; j < n; j++) {
                rightSet.add(s.charAt(j));
            }

            result[i] = leftSet.size() - rightSet.size();
        }

        return result;
    }
}
}