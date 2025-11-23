class Solution {
    public boolean isRationalEqual(String S, String T) {
        return parse(S).equals(parse(T));
    }

    private Double parse(String S) {
        String[] parts = S.split("\\.");
        double integerPart = Integer.parseInt(parts[0]);
        double decimalPart = 0.0;

        if (parts.length > 1) {
            String decimal = parts[1];
            if (decimal.contains("(")) {
                String[] decimalSplit = decimal.split("\\(");
                String nonRepeating = decimalSplit[0];
                String repeating = decimalSplit[1].replace(")", "");
                decimalPart += nonRepeating.isEmpty() ? 0 : Integer.parseInt(nonRepeating) / Math.pow(10, nonRepeating.length());
                decimalPart += Integer.parseInt(repeating) / (Math.pow(10, nonRepeating.length()) * (Math.pow(10, repeating.length()) - 1));
            } else {
                decimalPart += Integer.parseInt(decimal) / Math.pow(10, decimal.length());
            }
        }

        return integerPart + decimalPart;
    }
}