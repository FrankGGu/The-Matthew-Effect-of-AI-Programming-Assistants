import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> generateBinaryStrings(int n) {
        List<String> result = new ArrayList<>();
        backtrack(result, "", n);
        return result;
    }

    private void backtrack(List<String> result, String current, int remaining) {
        if (remaining == 0) {
            result.add(current);
            return;
        }
        if (current.isEmpty() || current.charAt(current.length() - 1) == '1') {
            backtrack(result, current + "1", remaining - 1);
        }
        backtrack(result, current + "0", remaining - 1);
    }
}