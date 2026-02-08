class Solution {
    public int strongPasswordChecker(String password) {
        int n = password.length();
        boolean hasLower = false, hasUpper = false, hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isDigit(c)) hasDigit = true;
        }
        int missingTypes = 3 - (hasLower ? 1 : 0) - (hasUpper ? 1 : 0) - (hasDigit ? 1 : 0);

        int replace = 0;
        int oneSeq = 0, twoSeq = 0;
        for (int i = 2; i < n; ) {
            if (password.charAt(i) == password.charAt(i - 1) && password.charAt(i - 1) == password.charAt(i - 2))) {
                int length = 2;
                while (i < n && password.charAt(i) == password.charAt(i - 1)) {
                    length++;
                    i++;
                }
                replace += length / 3;
                if (length % 3 == 0) oneSeq++;
                else if (length % 3 == 1) twoSeq++;
            } else {
                i++;
            }
        }

        if (n < 6) {
            return Math.max(6 - n, missingTypes);
        } else if (n <= 20) {
            return Math.max(replace, missingTypes);
        } else {
            int delete = n - 20;
            replace -= Math.min(delete, oneSeq * 1) / 1;
            replace -= Math.min(Math.max(delete - oneSeq, 0), twoSeq * 2) / 2;
            replace -= Math.max(delete - oneSeq - 2 * twoSeq, 0) / 3;
            return delete + Math.max(replace, missingTypes);
        }
    }
}