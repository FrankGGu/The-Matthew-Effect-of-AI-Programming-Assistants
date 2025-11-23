import java.util.ArrayList;
import java.util.List;

class Solution {
    List<String> result;
    char[] sChars;

    public List<String> letterCasePermutation(String s) {
        result = new ArrayList<>();
        sChars = s.toCharArray();
        backtrack(0, new StringBuilder());
        return result;
    }

    private void backtrack(int index, StringBuilder currentPermutation) {
        if (index == sChars.length) {
            result.add(currentPermutation.toString());
            return;
        }

        char c = sChars[index];

        if (Character.isDigit(c)) {
            currentPermutation.append(c);
            backtrack(index + 1, currentPermutation);
            currentPermutation.deleteCharAt(currentPermutation.length() - 1);
        } else {
            currentPermutation.append(Character.toLowerCase(c));
            backtrack(index + 1, currentPermutation);
            currentPermutation.deleteCharAt(currentPermutation.length() - 1);

            currentPermutation.append(Character.toUpperCase(c));
            backtrack(index + 1, currentPermutation);
            currentPermutation.deleteCharAt(currentPermutation.length() - 1);
        }
    }
}