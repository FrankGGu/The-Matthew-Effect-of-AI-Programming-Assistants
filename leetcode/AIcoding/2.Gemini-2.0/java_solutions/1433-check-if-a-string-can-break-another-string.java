import java.util.Arrays;

class Solution {
    public boolean checkIfCanBreak(String s1, String s2) {
        char[] c1 = s1.toCharArray();
        char[] c2 = s2.toCharArray();
        Arrays.sort(c1);
        Arrays.sort(c2);
        return canBreak(c1, c2) || canBreak(c2, c1);
    }

    private boolean canBreak(char[] s1, char[] s2) {
        for (int i = 0; i < s1.length; i++) {
            if (s1[i] < s2[i]) {
                return false;
            }
        }
        return true;
    }
}