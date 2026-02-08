class Solution {
    public String modifyString(String s) {
        StringBuilder result = new StringBuilder();
        char prev = '\0';

        for (char c : s.toCharArray()) {
            if (c == '?') {
                for (char replacement = 'a'; replacement <= 'z'; replacement++) {
                    if (replacement != prev && (result.length() == 0 || replacement != result.charAt(result.length() - 1))) {
                        result.append(replacement);
                        prev = replacement;
                        break;
                    }
                }
            } else {
                result.append(c);
                prev = c;
            }
        }

        return result.toString();
    }
}