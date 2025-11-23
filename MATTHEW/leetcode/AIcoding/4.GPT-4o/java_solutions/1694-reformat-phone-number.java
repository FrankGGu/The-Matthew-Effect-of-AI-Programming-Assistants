class Solution {
    public String reformatNumber(String number) {
        number = number.replaceAll("[^0-9]", "");
        StringBuilder result = new StringBuilder();
        int n = number.length();
        int i = 0;

        while (i < n) {
            if (i + 3 < n) {
                result.append(number, i, i + 3).append("-");
                i += 3;
            } else if (i + 2 < n) {
                result.append(number, i, i + 2).append("-");
                i += 2;
            } else {
                result.append(number, i, n);
                i = n;
            }
        }

        if (result.length() > 0 && result.charAt(result.length() - 1) == '-') {
            result.setLength(result.length() - 1);
        }

        return result.toString();
    }
}