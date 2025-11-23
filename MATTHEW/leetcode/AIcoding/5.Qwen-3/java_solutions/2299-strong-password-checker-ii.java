public class Solution {

import java.util.*;

public class Solution {
    public int strongPasswordCheckerII(String password) {
        boolean hasLower = false;
        boolean hasUpper = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;
        boolean hasConsecutive = false;

        String specialChars = "!@#$%^&*()-+";

        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);
            if (Character.isLowerCase(c)) hasLower = true;
            else if (Character.isUpperCase(c)) hasUpper = true;
            else if (Character.isDigit(c)) hasDigit = true;
            else if (specialChars.indexOf(c) >= 0) hasSpecial = true;

            if (i > 0 && c == password.charAt(i - 1)) {
                hasConsecutive = true;
            }
        }

        return (hasLower && hasUpper && hasDigit && hasSpecial && !hasConsecutive) ? 1 : 0;
    }
}
}