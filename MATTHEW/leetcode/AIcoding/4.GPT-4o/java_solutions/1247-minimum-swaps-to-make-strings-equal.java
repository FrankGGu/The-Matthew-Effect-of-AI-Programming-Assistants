public class Solution {
    public int minimumSwaps(String s1, String s2) {
        if (s1.length() != s2.length()) return -1;

        int n = s1.length();
        int xy = 0, yx = 0;

        for (int i = 0; i < n; i++) {
            if (s1.charAt(i) == 'x' && s2.charAt(i) == 'y') {
                xy++;
            } else if (s1.charAt(i) == 'y' && s2.charAt(i) == 'x') {
                yx++;
            }
        }

        int swaps = (xy + 1) / 2 + (yx + 1) / 2;
        return (xy % 2 + yx % 2) == 0 ? swaps : -1;
    }
}