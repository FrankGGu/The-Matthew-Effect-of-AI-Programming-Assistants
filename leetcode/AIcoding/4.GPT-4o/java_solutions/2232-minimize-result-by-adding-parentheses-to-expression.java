class Solution {
    public String minimizeResult(String expression) {
        String[] parts = expression.split("\\+");
        String left = parts[0];
        String right = parts[1];
        int minValue = Integer.MAX_VALUE;
        String result = "";

        for (int i = 0; i <= left.length(); i++) {
            for (int j = 1; j <= right.length(); j++) {
                String modifiedLeft = (i == 0 ? "" : left.substring(0, i)) + "(" + left.substring(i) + "+" + right.substring(0, j) + ")";
                String modifiedRight = right.substring(j) + ")";
                String finalExpression = modifiedLeft + modifiedRight;

                int value = evaluate(finalExpression);
                if (value < minValue) {
                    minValue = value;
                    result = finalExpression;
                }
            }
        }
        return result;
    }

    private int evaluate(String expression) {
        String[] parts = expression.replace("(", "").replace(")", "").split("\\+");
        return Integer.parseInt(parts[0]) + Integer.parseInt(parts[1]);
    }
}