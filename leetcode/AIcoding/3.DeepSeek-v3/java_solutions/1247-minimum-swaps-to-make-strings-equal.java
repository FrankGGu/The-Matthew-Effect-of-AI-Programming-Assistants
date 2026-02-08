class Solution {
    public int minimumSwap(String s1, String s2) {
        int x = 0, y = 0;
        for (int i = 0; i < s1.length(); i++) {
            if (s1.charAt(i) != s2.charAt(i)) {
                if (s1.charAt(i) == 'x') {
                    x++;
                } else {
                    y++;
                }
            }
        }
        if ((x + y) % 2 != 0) {
            return -1;
        }
        return (x + 1) / 2 + (y + 1) / 2;
    }
}