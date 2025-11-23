public class Solution {
    public boolean canTransform(int src, int dest) {
        String s = Integer.toBinaryString(src);
        String t = Integer.toBinaryString(dest);
        int i = 0, j = 0;
        while (i < s.length() && j < t.length()) {
            if (s.charAt(i) != t.charAt(j)) {
                if (s.charAt(i) == '1' && t.charAt(j) == '0') {
                    return false;
                } else if (s.charAt(i) == '0' && t.charAt(j) == '1') {
                    return false;
                }
            }
            i++;
            j++;
        }
        return true;
    }
}