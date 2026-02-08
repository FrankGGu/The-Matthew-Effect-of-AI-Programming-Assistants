class Solution {
    public boolean strongPasswordCheckerII(String password) {
        if (password.length() < 8) return false;

        boolean hasLower = false, hasUpper = false, hasDigit = false, hasSpecial = false;
        String specialChars = "!@#$%^&*()-+";

        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);
            if (Character.isLowerCase(c)) hasLower = true;
            if (Character.isUpperCase(c)) hasUpper = true;
            if (Character.isDigit(c)) hasDigit = true;
            if (specialChars.indexOf(c) >= 0) hasSpecial = true;
            if (i > 0 && c == password.charAt(i - 1)) return false; // Check for repeating characters
        }

        return hasLower && hasUpper && hasDigit && hasSpecial;
    }
}