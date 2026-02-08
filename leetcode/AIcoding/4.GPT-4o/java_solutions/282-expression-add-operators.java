import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<String> addOperators(String num, int target) {
        List<String> result = new ArrayList<>();
        backtrack(result, "", num, target, 0, 0, 0);
        return result;
    }

    private void backtrack(List<String> result, String expression, String num, int target, int index, long prevOperand, long currentOperand) {
        if (index == num.length()) {
            if (currentOperand == target) {
                result.add(expression);
            }
            return;
        }

        for (int i = index; i < num.length(); i++) {
            String currentNumStr = num.substring(index, i + 1);
            long currentNum = Long.parseLong(currentNumStr);
            if (i > index && currentNumStr.charAt(0) == '0') break;

            if (index == 0) {
                backtrack(result, currentNumStr, num, target, i + 1, currentNum, currentNum);
            } else {
                backtrack(result, expression + "+" + currentNumStr, num, target, i + 1, currentNum, currentOperand + currentNum);
                backtrack(result, expression + "-" + currentNumStr, num, target, i + 1, -currentNum, currentOperand - currentNum);
                backtrack(result, expression + "*" + currentNumStr, num, target, i + 1, prevOperand * currentNum, currentOperand - prevOperand + (prevOperand * currentNum));
            }
        }
    }
}