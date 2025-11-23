class Solution {
    public int strongPasswordChecker(String password) {
        int n = password.length();
        boolean hasLower = false, hasUpper = false, hasDigit = false;
        for (char c : password.toCharArray()) {
            if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isDigit(c)) hasDigit = true;
        }

        int missingTypes = (hasLower ? 0 : 1) + (hasUpper ? 0 : 1) + (hasDigit ? 0 : 1);
        if (n < 6) return Math.max(6 - n, missingTypes);
        if (n <= 20) return missingTypes;

        int[] count = new int[3];
        int excess = n - 20;
        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && password.charAt(j) == password.charAt(i)) j++;
            int len = j - i;
            if (len >= 3) count[len % 3]++;
            i = j;
        }

        int replace = count[0] + count[1] + count[2];
        if (excess > 0) {
            for (int i = 0; i < 3 && excess > 0; i++) {
                while (count[i] > 0 && excess > 0) {
                    count[i]--;
                    excess--;
                }
            }
            replace += excess;
        }

        return 3 + Math.max(0, missingTypes - replace);
    }
}