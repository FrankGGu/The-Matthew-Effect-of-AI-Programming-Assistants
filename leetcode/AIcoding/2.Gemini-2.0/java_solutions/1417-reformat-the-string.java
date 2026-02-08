class Solution {
    public String reformat(String s) {
        StringBuilder digits = new StringBuilder();
        StringBuilder letters = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                digits.append(c);
            } else {
                letters.append(c);
            }
        }
        if (Math.abs(digits.length() - letters.length()) > 1) {
            return "";
        }
        StringBuilder result = new StringBuilder();
        if (digits.length() > letters.length()) {
            for (int i = 0; i < letters.length(); i++) {
                result.append(digits.charAt(i));
                result.append(letters.charAt(i));
            }
            result.append(digits.charAt(letters.length()));
        } else if (letters.length() > digits.length()) {
            for (int i = 0; i < digits.length(); i++) {
                result.append(letters.charAt(i));
                result.append(digits.charAt(i));
            }
            result.append(letters.charAt(digits.length()));
        } else {
            for (int i = 0; i < digits.length(); i++) {
                result.append(digits.charAt(i));
                result.append(letters.charAt(i));
            }
        }
        return result.toString();
    }
}