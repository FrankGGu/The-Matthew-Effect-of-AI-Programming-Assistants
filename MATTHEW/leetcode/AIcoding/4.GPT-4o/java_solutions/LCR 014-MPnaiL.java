import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Solution {
    public List<String> permutation(String s) {
        List<String> result = new ArrayList<>();
        char[] chars = s.toCharArray();
        Arrays.sort(chars);
        backtrack(result, new StringBuilder(), chars, new boolean[chars.length]);
        return result;
    }

    private void backtrack(List<String> result, StringBuilder current, char[] chars, boolean[] used) {
        if (current.length() == chars.length) {
            result.add(current.toString());
            return;
        }
        for (int i = 0; i < chars.length; i++) {
            if (used[i]) continue;
            if (i > 0 && chars[i] == chars[i - 1] && !used[i - 1]) continue;
            used[i] = true;
            current.append(chars[i]);
            backtrack(result, current, chars, used);
            used[i] = false;
            current.deleteCharAt(current.length() - 1);
        }
    }
}