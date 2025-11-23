import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> letterCombinations(String digits) {
        List<String> result = new ArrayList<>();
        if (digits.isEmpty()) {
            return result;
        }
        String[] mapping = {"", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
        backtrack(result, new StringBuilder(), digits, mapping, 0);
        return result;
    }

    private void backtrack(List<String> result, StringBuilder combination, String digits, String[] mapping, int index) {
        if (index == digits.length()) {
            result.add(combination.toString());
            return;
        }
        String letters = mapping[digits.charAt(index) - '0'];
        for (char letter : letters.toCharArray()) {
            combination.append(letter);
            backtrack(result, combination, digits, mapping, index + 1);
            combination.deleteCharAt(combination.length() - 1);
        }
    }
}