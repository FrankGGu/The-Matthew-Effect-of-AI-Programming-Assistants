class Solution {
    public String reformat(String s) {
        List<Character> digits = new ArrayList<>();
        List<Character> letters = new ArrayList<>();

        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                digits.add(c);
            } else {
                letters.add(c);
            }
        }

        if (Math.abs(digits.size() - letters.size()) > 1) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        boolean digitFirst = digits.size() > letters.size();

        int i = 0, j = 0;
        while (i < digits.size() || j < letters.size()) {
            if (digitFirst) {
                if (i < digits.size()) {
                    sb.append(digits.get(i++));
                }
                if (j < letters.size()) {
                    sb.append(letters.get(j++));
                }
            } else {
                if (j < letters.size()) {
                    sb.append(letters.get(j++));
                }
                if (i < digits.size()) {
                    sb.append(digits.get(i++));
                }
            }
        }

        return sb.toString();
    }
}