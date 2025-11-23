class Solution {
    public String makeFancyString(String s) {
        StringBuilder sb = new StringBuilder();
        int count = 0;
        char prevChar = '\0';

        for (char c : s.toCharArray()) {
            if (c == prevChar) {
                count++;
            } else {
                count = 1;
                prevChar = c;
            }
            if (count < 3) {
                sb.append(c);
            }
        }

        return sb.toString();
    }
}