public class Solution {
    public boolean isAdditiveNumber(String num) {
        int n = num.length();
        for (int i = 1; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (isValid(num, 0, i, j)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean isValid(String num, int start, int i, int j) {
        String first = num.substring(start, i);
        String second = num.substring(i, j);
        if (first.length() > 1 && first.charAt(0) == '0') return false;
        if (second.length() > 1 && second.charAt(0) == '0') return false;

        String sum = addStrings(first, second);
        int k = j;
        while (k < num.length()) {
            if (!num.startsWith(sum, k)) return false;
            k += sum.length();
            first = second;
            second = sum;
            sum = addStrings(first, second);
        }
        return true;
    }

    private String addStrings(String num1, String num2) {
        StringBuilder sb = new StringBuilder();
        int carry = 0, i = num1.length() - 1, j = num2.length() - 1;
        while (i >= 0 || j >= 0 || carry > 0) {
            int x = (i >= 0) ? num1.charAt(i) - '0' : 0;
            int y = (j >= 0) ? num2.charAt(j) - '0' : 0;
            int sum = x + y + carry;
            sb.append(sum % 10);
            carry = sum / 10;
            i--;
            j--;
        }
        return sb.reverse().toString();
    }
}