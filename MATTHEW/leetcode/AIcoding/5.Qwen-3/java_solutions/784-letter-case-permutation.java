public class Solution {

import java.util.*;

public class Solution {
    public List<String> letterCasePermutation(String s) {
        List<String> result = new ArrayList<>();
        dfs(s, 0, new char[s.length()], result);
        return result;
    }

    private void dfs(String s, int index, char[] path, List<String> result) {
        if (index == s.length()) {
            result.add(new String(path));
            return;
        }
        char c = s.charAt(index);
        if (Character.isDigit(c)) {
            path[index] = c;
            dfs(s, index + 1, path, result);
        } else {
            path[index] = Character.toLowerCase(c);
            dfs(s, index + 1, path, result);
            path[index] = Character.toUpperCase(c);
            dfs(s, index + 1, path, result);
        }
    }
}
}