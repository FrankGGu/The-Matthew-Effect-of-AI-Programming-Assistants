public class Solution {
    public int countSpecialSubsequences(String s) {
        long a = 0, ab = 0, abc = 0;
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                a = (a + 1) % (1000000007);
            } else if (c == 'b') {
                ab = (ab + a) % (1000000007);
            } else if (c == 'c') {
                abc = (abc + ab) % (1000000007);
            }
        }
        return (int) abc;
    }
}