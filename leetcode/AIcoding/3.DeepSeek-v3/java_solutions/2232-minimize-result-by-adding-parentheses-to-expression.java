class Solution {
    public String minimizeResult(String expression) {
        int plusPos = expression.indexOf('+');
        String left = expression.substring(0, plusPos);
        String right = expression.substring(plusPos + 1);
        int minVal = Integer.MAX_VALUE;
        String result = "";

        for (int i = 0; i < left.length(); i++) {
            for (int j = 1; j <= right.length(); j++) {
                String aStr = left.substring(0, i);
                String bStr = left.substring(i);
                String cStr = right.substring(0, j);
                String dStr = right.substring(j);

                int a = aStr.isEmpty() ? 1 : Integer.parseInt(aStr);
                int b = Integer.parseInt(bStr);
                int c = Integer.parseInt(cStr);
                int d = dStr.isEmpty() ? 1 : Integer.parseInt(dStr);

                int current = a * (b + c) * d;
                if (current < minVal) {
                    minVal = current;
                    result = (aStr.isEmpty() ? "" : aStr) + "(" + bStr + "+" + cStr + ")" + (dStr.isEmpty() ? "" : dStr);
                }
            }
        }
        return result;
    }
}