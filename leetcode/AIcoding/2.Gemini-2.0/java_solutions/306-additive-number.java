class Solution {
    public boolean isAdditiveNumber(String num) {
        int n = num.length();
        for (int i = 1; i <= n / 2; i++) {
            for (int j = 1; j <= (n - i) / 2; j++) {
                if (isAdditive(num, 0, i, j)) {
                    return true;
                }
            }
        }
        return false;
    }

    private boolean isAdditive(String num, int start, int len1, int len2) {
        if (start + len1 + len2 == num.length()) {
            return true;
        }

        long num1 = parseLong(num, start, len1);
        long num2 = parseLong(num, start + len1, len2);

        if (num1 == -1 || num2 == -1) {
            return false;
        }

        long sum = num1 + num2;
        String sumStr = String.valueOf(sum);
        int sumLen = sumStr.length();

        if (start + len1 + len2 + sumLen > num.length()) {
            return false;
        }

        String sub = num.substring(start + len1 + len2, start + len1 + len2 + sumLen);
        if (!sumStr.equals(sub)) {
            return false;
        }

        return isAdditive(num, start + len1, len2, sumLen);
    }

    private long parseLong(String num, int start, int len) {
        if (len > 1 && num.charAt(start) == '0') {
            return -1;
        }
        String sub = num.substring(start, start + len);
        try {
            return Long.parseLong(sub);
        } catch (NumberFormatException e) {
            return -1;
        }
    }
}