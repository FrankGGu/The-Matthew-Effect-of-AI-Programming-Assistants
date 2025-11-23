class Solution {
    public String minimizeResult(String expression) {
        int plusIndex = expression.indexOf('+');
        String num1Str = expression.substring(0, plusIndex);
        String num2Str = expression.substring(plusIndex + 1);

        long minResult = Long.MAX_VALUE;
        String bestExpression = "";

        // i is the split point for num1Str: num1Str.substring(0, i) is prefix, num1Str.substring(i) is suffix
        // num1_prefix_str corresponds to A, num1_suffix_str corresponds to B
        for (int i = 0; i < num1Str.length(); i++) {
            String num1_prefix_str = num1Str.substring(0, i);
            String num1_suffix_str = num1Str.substring(i);

            // j is the split point for num2Str: num2Str.substring(0, j) is prefix, num2Str.substring(j) is suffix
            // num2_prefix_str corresponds to C, num2_suffix_str corresponds to D
            // C must be non-empty, so j starts from 1
            for (int j = 1; j <= num2Str.length(); j++) {
                String num2_prefix_str = num2Str.substring(0, j);
                String num2_suffix_str = num2Str.substring(j);

                long valA = num1_prefix_str.isEmpty() ? 1 : Long.parseLong(num1_prefix_str);
                long valB = Long.parseLong(num1_suffix_str);
                long valC = Long.parseLong(num2_prefix_str);
                long valD = num2_suffix_str.isEmpty() ? 1 : Long.parseLong(num2_suffix_str);

                long currentResult = valA * (valB + valC) * valD;

                if (currentResult < minResult) {
                    minResult = currentResult;
                    // Construct the formatted string
                    StringBuilder sb = new StringBuilder();
                    sb.append(num1_prefix_str);
                    sb.append("(");
                    sb.append(num1_suffix_str);
                    sb.append("+");
                    sb.append(num2_prefix_str);
                    sb.append(")");
                    sb.append(num2_suffix_str);
                    bestExpression = sb.toString();
                }
            }
        }
        return bestExpression;
    }
}