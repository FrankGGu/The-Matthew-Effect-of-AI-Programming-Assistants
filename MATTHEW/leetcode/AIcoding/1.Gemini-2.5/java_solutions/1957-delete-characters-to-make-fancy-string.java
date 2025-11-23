class Solution {
    public String makeFancyString(String s) {
        if (s == null || s.length() < 3) {
            return s;
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char currentChar = s.charAt(i);
            if (sb.length() < 2) {
                sb.append(currentChar);
            } else {
                if (currentChar == sb.charAt(sb.length() - 1) && currentChar == sb.charAt(sb.length() - 2)) {
                    // This character would make three consecutive identical characters, so skip it
                    continue;
                } else {
                    sb.append(currentChar);
                }
            }
        }

        return sb.toString();
    }
}