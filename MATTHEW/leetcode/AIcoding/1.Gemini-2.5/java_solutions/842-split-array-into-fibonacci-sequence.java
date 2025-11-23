import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<Integer> result;
    private String S;

    public List<Integer> splitIntoFibonacci(String S) {
        this.result = new ArrayList<>();
        this.S = S;
        List<Integer> current = new ArrayList<>();
        backtrack(0, current);
        return result;
    }

    private boolean backtrack(int index, List<Integer> current) {
        if (index == S.length()) {
            return current.size() >= 3;
        }

        for (int i = index; i < S.length(); i++) {
            if (S.charAt(index) == '0' && i > index) {
                break;
            }

            long num;
            try {
                num = Long.parseLong(S.substring(index, i + 1));
            } catch (NumberFormatException e) {
                break;
            }

            if (num > Integer.MAX_VALUE) {
                break;
            }

            int currentNum = (int) num;

            if (current.size() < 2) {
                current.add(currentNum);
                if (backtrack(i + 1, current)) {
                    result.addAll(current);
                    return true;
                }
                current.remove(current.size() - 1);
            } else {
                long prev1 = current.get(current.size() - 2);
                long prev2 = current.get(current.size() - 1);
                long expectedSum = prev1 + prev2;

                if (currentNum < expectedSum) {
                    continue;
                } else if (currentNum > expectedSum) {
                    break;
                } else { // currentNum == expectedSum
                    current.add(currentNum);
                    if (backtrack(i + 1, current)) {
                        result.addAll(current);
                        return true;
                    }
                    current.remove(current.size() - 1);
                }
            }
        }
        return false;
    }
}