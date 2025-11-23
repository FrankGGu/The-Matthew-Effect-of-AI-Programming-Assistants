public class Solution {
    public String minimizeResult(String expression) {
        int plusIndex = expression.indexOf('+');
        String left = expression.substring(0, plusIndex);
        String right = expression.substring(plusIndex + 1);

        int minVal = Integer.MAX_VALUE;
        String result = "";

        for (int i = 0; i < left.length(); i++) {
            for (int j = 1; j <= right.length(); j++) {
                int leftPart = Integer.parseInt(left.substring(0, i)) * Integer.parseInt(left.substring(i));
                int rightPart = Integer.parseInt(right.substring(0, j)) * Integer.parseInt(right.substring(j));
                int total = leftPart + rightPart;

                if (total < minVal) {
                    minVal = total;
                    result = "(" + left.substring(0, i) + left.substring(i) + "+" + right.substring(0, j) + right.substring(j) + ")";
                }
            }
        }

        return result;
    }
}