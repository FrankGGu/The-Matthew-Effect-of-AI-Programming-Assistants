class Solution {
    public int maximumGain(String s, int x, int y) {
        char[] chars = s.toCharArray();
        int score = 0;
        if (x > y) {
            score += remove(chars, 'a', 'b', x);
            score += remove(chars, 'b', 'a', y);
        } else {
            score += remove(chars, 'b', 'a', y);
            score += remove(chars, 'a', 'b', x);
        }
        return score;
    }

    private int remove(char[] chars, char first, char second, int score) {
        int res = 0;
        int i = 0, j = 0;
        while (j < chars.length) {
            chars[i] = chars[j];
            if (i > 0 && chars[i - 1] == first && chars[i] == second) {
                i -= 2;
                res += score;
            }
            i++;
            j++;
        }
        char[] newChars = new char[i];
        System.arraycopy(chars, 0, newChars, 0, i);
        chars = newChars;
        return res;
    }
}