public class Solution {

import java.util.*;

public class Solution {
    public boolean isPalindrome(String s) {
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

    public boolean dfs(String s, int index, Set<Integer> visited) {
        if (index == s.length()) {
            return true;
        }
        if (visited.contains(index)) {
            return false;
        }
        visited.add(index);
        char c = s.charAt(index);
        int nextIndex = index + 1;
        while (nextIndex < s.length() && s.charAt(nextIndex) == c) {
            nextIndex++;
        }
        return dfs(s, nextIndex, visited);
    }

    public boolean checkIfDFSStringsArePalindromes(String s) {
        Set<Integer> visited = new HashSet<>();
        return dfs(s, 0, visited) && isPalindrome(s);
    }
}
}