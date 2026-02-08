import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    private List<String> result = new ArrayList<>();
    private char[] chars;
    private boolean[] used;
    private StringBuilder currentPermutation = new StringBuilder();

    public List<String> permutation(String s) {
        chars = s.toCharArray();
        Arrays.sort(chars);
        used = new boolean[chars.length];

        backtrack();
        return result;
    }

    private void backtrack() {
        if (currentPermutation.length() == chars.length) {
            result.add(currentPermutation.toString());
            return;
        }

        for (int i = 0; i < chars.length; i++) {
            if (used[i]) {
                continue;
            }

            if (i > 0 && chars[i] == chars[i - 1] && !used[i - 1]) {
                continue;
            }

            used[i] = true;
            currentPermutation.append(chars[i]);
            backtrack();
            currentPermutation.deleteCharAt(currentPermutation.length() - 1);
            used[i] = false;
        }
    }
}