class Solution {
    public String reverseDegreeOfString(String s) {
        s = s.trim();
        String[] words = s.split("\\s+");
        StringBuilder reversedString = new StringBuilder();
        for (int i = words.length - 1; i >= 0; i--) {
            reversedString.append(words[i]);
            if (i > 0) {
                reversedString.append(" ");
            }
        }
        return reversedString.toString();
    }
}