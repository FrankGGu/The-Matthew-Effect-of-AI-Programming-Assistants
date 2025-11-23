public class Solution {

import java.util.*;

public class Solution {
    public List<String> partition(String s) {
        List<String> result = new ArrayList<>();
        helper(s, 0, new ArrayList<>(), result);
        return result;
    }

    private void helper(String s, int start, List<String> current, List<String> result) {
        if (start == s.length()) {
            result.add(String.join("", current));
            return;
        }
        for (int end = start + 1; end <= s.length(); end++) {
            String substr = s.substring(start, end);
            if (isPalindrome(substr)) {
                current.add(substr);
                helper(s, end, current, result);
                current.remove(current.size() - 1);
            }
        }
    }

    private boolean isPalindrome(String s) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}
}