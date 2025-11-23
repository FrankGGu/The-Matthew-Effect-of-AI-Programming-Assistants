import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> splitIntoFibonacci(String S) {
        List<Integer> result = new ArrayList<>();
        backtrack(S, 0, result);
        return result;
    }

    private boolean backtrack(String S, int start, List<Integer> current) {
        if (start == S.length() && current.size() >= 3) {
            return true;
        }

        for (int end = start + 1; end <= S.length(); end++) {
            String part = S.substring(start, end);
            if (part.length() > 1 && part.charAt(0) == '0') {
                break;
            }
            long num = Long.parseLong(part);
            if (num > Integer.MAX_VALUE) {
                break;
            }
            current.add((int) num);
            if (current.size() >= 3) {
                int size = current.size();
                if (current.get(size - 1) == current.get(size - 2) + current.get(size - 3)) {
                    if (backtrack(S, end, current)) {
                        return true;
                    }
                }
            } else {
                if (backtrack(S, end, current)) {
                    return true;
                }
            }
            current.remove(current.size() - 1);
        }
        return false;
    }
}