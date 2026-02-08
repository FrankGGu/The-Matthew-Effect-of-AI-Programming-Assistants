public class Solution {

import java.util.*;

public class Solution {
    public int maxLength(List<String> arr) {
        List<String> validArr = new ArrayList<>();
        for (String s : arr) {
            if (hasUniqueChars(s)) {
                validArr.add(s);
            }
        }
        return backtrack(validArr, 0, "");
    }

    private boolean hasUniqueChars(String s) {
        Set<Character> set = new HashSet<>();
        for (char c : s.toCharArray()) {
            if (set.contains(c)) {
                return false;
            }
            set.add(c);
        }
        return true;
    }

    private int backtrack(List<String> arr, int start, String current) {
        int maxLen = current.length();
        for (int i = start; i < arr.size(); i++) {
            if (hasUniqueChars(current + arr.get(i))) {
                maxLen = Math.max(maxLen, backtrack(arr, i + 1, current + arr.get(i)));
            }
        }
        return maxLen;
    }
}
}