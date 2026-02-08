class Solution {
    public String reformatNumber(String number) {
        StringBuilder digits = new StringBuilder();
        for (char c : number.toCharArray()) {
            if (Character.isDigit(c)) {
                digits.append(c);
            }
        }

        int n = digits.length();
        StringBuilder result = new StringBuilder();
        int i = 0;
        while (i < n) {
            if (n - i > 4) {
                result.append(digits.substring(i, i + 3));
                i += 3;
            } else {
                if (n - i == 4) {
                    result.append(digits.substring(i, i + 2));
                    i += 2;
                    result.append('-');
                    result.append(digits.substring(i, i + 2));
                    i += 2;
                } else {
                    result.append(digits.substring(i, n));
                    i = n;
                }
            }
            if (i < n) {
                result.append('-');
            }
        }
        return result.toString();
    }
}