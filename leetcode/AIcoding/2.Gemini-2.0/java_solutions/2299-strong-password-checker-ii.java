class Solution {
    public boolean strongPasswordCheckerII(String password) {
        if (password.length() < 8) {
            return false;
        }

        boolean lower = false;
        boolean upper = false;
        boolean digit = false;
        boolean special = false;

        String specialChars = "!@#$%^&*()-+";

        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);

            if (Character.isLowerCase(c)) {
                lower = true;
            } else if (Character.isUpperCase(c)) {
                upper = true;
            } else if (Character.isDigit(c)) {
                digit = true;
            } else if (specialChars.indexOf(c) != -1) {
                special = true;
            }

            if (i > 0 && password.charAt(i) == password.charAt(i - 1)) {
                return false;
            }
        }

        return lower && upper && digit && special;
    }
}