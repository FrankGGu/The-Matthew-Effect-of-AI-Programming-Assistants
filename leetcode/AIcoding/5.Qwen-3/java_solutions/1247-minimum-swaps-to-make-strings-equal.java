public class Solution {
    public int minSwap(String s1, String s2) {
        int x = 0, y = 0;
        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                if (s1.charAt(i) == 'x') x++;
                else y++;
            }
        }
        return (x + 1) / 2 + (y + 1) / 2;
    }
}