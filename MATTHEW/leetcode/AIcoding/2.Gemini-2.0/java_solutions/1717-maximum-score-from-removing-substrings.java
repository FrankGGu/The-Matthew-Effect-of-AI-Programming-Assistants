class Solution {
    public int maximumGain(String s, int x, int y) {
        int score = 0;
        if (x > y) {
            score = calculateScore(s, "ab", "ba", x, y);
        } else {
            score = calculateScore(s, "ba", "ab", y, x);
        }
        return score;
    }

    private int calculateScore(String s, String first, String second, int x, int y) {
        int score = 0;
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            sb.append(c);
            while (sb.length() >= 2 && sb.substring(sb.length() - 2).equals(first)) {
                score += x;
                sb.delete(sb.length() - 2, sb.length());
            }
        }

        StringBuilder sb2 = new StringBuilder();
        for (int i = 0; i < sb.length(); i++) {
            sb2.append(sb.charAt(i));
            while (sb2.length() >= 2 && sb2.substring(sb2.length() - 2).equals(second)) {
                score += y;
                sb2.delete(sb2.length() - 2, sb2.length());
            }
        }
        return score;
    }
}