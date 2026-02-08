public class Solution {
    public int minFlipsAlternatingBinaryString(String s) {
        int n = s.length();
        int flip0 = 0, flip1 = 0;
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            if (i % 2 == 0) {
                if (c != '0') flip0++;
                if (c != '1') flip1++;
            } else {
                if (c != '1') flip0++;
                if (c != '0') flip1++;
            }
        }
        return Math.min(flip0, flip1);
    }
}