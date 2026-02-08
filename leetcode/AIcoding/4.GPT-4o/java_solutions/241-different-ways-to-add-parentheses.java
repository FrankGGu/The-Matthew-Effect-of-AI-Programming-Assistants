import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> diffWaysToCompute(String expression) {
        List<Integer> results = new ArrayList<>();
        for (int i = 0; i < expression.length(); i++) {
            char c = expression.charAt(i);
            if (c == '+' || c == '-' || c == '*') {
                String left = expression.substring(0, i);
                String right = expression.substring(i + 1);
                List<Integer> leftResults = diffWaysToCompute(left);
                List<Integer> rightResults = diffWaysToCompute(right);
                for (int l : leftResults) {
                    for (int r : rightResults) {
                        if (c == '+') {
                            results.add(l + r);
                        } else if (c == '-') {
                            results.add(l - r);
                        } else if (c == '*') {
                            results.add(l * r);
                        }
                    }
                }
            }
        }
        if (results.isEmpty()) {
            results.add(Integer.valueOf(expression));
        }
        return results;
    }
}