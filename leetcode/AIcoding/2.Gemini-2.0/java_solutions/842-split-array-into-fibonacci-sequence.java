import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> splitIntoFibonacci(String s) {
        List<Integer> result = new ArrayList<>();
        backtrack(s, 0, result);
        return result;
    }

    private boolean backtrack(String s, int index, List<Integer> result) {
        if (index == s.length() && result.size() >= 3) {
            return true;
        }

        for (int i = index; i < s.length(); i++) {
            if (s.charAt(index) == '0' && i > index) {
                break;
            }

            long num = Long.parseLong(s.substring(index, i + 1));
            if (num > Integer.MAX_VALUE) {
                break;
            }

            int size = result.size();
            if (size >= 2 && (long)result.get(size - 1) + (long)result.get(size - 2) < num) {
                continue;
            }

            if (size >= 2 && (long)result.get(size - 1) + (long)result.get(size - 2) > num) {
                continue;
            }

            if (size < 2 || (long)result.get(size - 1) + (long)result.get(size - 2) == num) {
                result.add((int) num);
                if (backtrack(s, i + 1, result)) {
                    return true;
                }
                result.remove(result.size() - 1);
            }
        }

        return false;
    }
}