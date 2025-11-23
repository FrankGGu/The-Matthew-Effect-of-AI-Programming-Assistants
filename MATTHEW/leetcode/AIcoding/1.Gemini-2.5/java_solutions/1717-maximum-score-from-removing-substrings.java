class Solution {
    public int maximumGain(String s, int x, int y) {
        int totalScore = 0;
        String s1 = s;
        String s2;

        char firstChar1, secondChar1;
        int score1;
        char firstChar2, secondChar2;
        int score2;

        if (x >= y) {
            firstChar1 = 'a'; secondChar1 = 'b'; score1 = x;
            firstChar2 = 'b'; secondChar2 = 'a'; score2 = y;
        } else {
            firstChar1 = 'b'; secondChar1 = 'a'; score1 = y;
            firstChar2 = 'a'; secondChar2 = 'b'; score2 = x;
        }

        StringBuilder sb1 = new StringBuilder();
        for (char c : s1.toCharArray()) {
            if (c == secondChar1 && sb1.length() > 0 && sb1.charAt(sb1.length() - 1) == firstChar1) {
                sb1.deleteCharAt(sb1.length() - 1);
                totalScore += score1;
            } else {
                sb1.append(c);
            }
        }
        s2 = sb1.toString();

        StringBuilder sb2 = new StringBuilder();
        for (char c : s2.toCharArray()) {
            if (c == secondChar2 && sb2.length() > 0 && sb2.charAt(sb2.length() - 1) == firstChar2) {
                sb2.deleteCharAt(sb2.length() - 1);
                totalScore += score2;
            } else {
                sb2.append(c);
            }
        }

        return totalScore;
    }
}