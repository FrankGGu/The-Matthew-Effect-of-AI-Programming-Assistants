import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> letterCasePermutation(String s) {
        List<String> result = new ArrayList<>();
        backtrack(result, s.toCharArray(), 0);
        return result;
    }

    private void backtrack(List<String> result, char[] chars, int index) {
        if (index == chars.length) {
            result.add(new String(chars));
            return;
        }
        backtrack(result, chars, index + 1);
        if (Character.isLetter(chars[index])) {
            chars[index] ^= 32; // Toggle case
            backtrack(result, chars, index + 1);
            chars[index] ^= 32; // Revert case
        }
    }
}