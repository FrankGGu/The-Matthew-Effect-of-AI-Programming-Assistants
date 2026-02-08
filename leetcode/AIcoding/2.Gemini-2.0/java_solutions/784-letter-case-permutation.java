import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> letterCasePermutation(String s) {
        List<String> result = new ArrayList<>();
        backtrack(s, 0, new StringBuilder(), result);
        return result;
    }

    private void backtrack(String s, int index, StringBuilder current, List<String> result) {
        if (index == s.length()) {
            result.add(current.toString());
            return;
        }

        char ch = s.charAt(index);
        if (Character.isLetter(ch)) {
            current.append(Character.toLowerCase(ch));
            backtrack(s, index + 1, current, result);
            current.deleteCharAt(current.length() - 1);

            current.append(Character.toUpperCase(ch));
            backtrack(s, index + 1, current, result);
            current.deleteCharAt(current.length() - 1);
        } else {
            current.append(ch);
            backtrack(s, index + 1, current, result);
            current.deleteCharAt(current.length() - 1);
        }
    }
}