class Solution {
    public String maxValue(String n, int x) {
        StringBuilder sb = new StringBuilder(n);
        char xChar = (char)(x + '0');

        boolean isNegative = n.charAt(0) == '-';
        int startIndex = isNegative ? 1 : 0;

        if (isNegative) {
            // For negative numbers, to maximize the value, we want to make its absolute value smaller.
            // This means inserting x at the first position where x is smaller than the current digit.
            for (int i = startIndex; i < sb.length(); i++) {
                if (xChar < sb.charAt(i)) {
                    sb.insert(i, xChar);
                    return sb.toString();
                }
            }
        } else {
            // For positive numbers, to maximize the value, we want to make it larger.
            // This means inserting x at the first position where x is greater than the current digit.
            for (int i = startIndex; i < sb.length(); i++) {
                if (xChar > sb.charAt(i)) {
                    sb.insert(i, xChar);
                    return sb.toString();
                }
            }
        }

        // If x was not inserted in the loop, it means it should be appended at the end.
        // (For positive n, x is smaller than or equal to all digits; for negative n, x is greater than or equal to all digits).
        sb.append(xChar);
        return sb.toString();
    }
}