class Solution {
    public String reformat(String s) {
        StringBuilder letters = new StringBuilder();
        StringBuilder digits = new StringBuilder();

        for (char c : s.toCharArray()) {
            if (Character.isLetter(c)) {
                letters.append(c);
            } else {
                digits.append(c);
            }
        }

        if (Math.abs(letters.length() - digits.length()) > 1) {
            return "";
        }

        StringBuilder result = new StringBuilder();
        String longer = letters.length() > digits.length() ? letters.toString() : digits.toString();
        String shorter = letters.length() > digits.length() ? digits.toString() : letters.toString();

        for (int i = 0; i < longer.length(); i++) {
            result.append(longer.charAt(i));
            if (i < shorter.length()) {
                result.append(shorter.charAt(i));
            }
        }

        return result.toString();
    }
}