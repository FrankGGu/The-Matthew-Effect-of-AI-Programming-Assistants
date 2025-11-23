public class Solution {
    public int countSpecialSubsequences(String s) {
        int a = 0, ab = 0, abc = 0;
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                a = a + 1;
            } else if (c == 'b') {
                ab = ab + a;
            } else if (c == 'c') {
                abc = abc + ab;
            }
        }
        return abc;
    }
}