public class Solution {
    public boolean isSumEqual(String s1, String s2, String s3) {
        int val1 = 0;
        int val2 = 0;
        int val3 = 0;

        for (char c : s1.toCharArray()) {
            val1 = val1 * 10 + (c - 'a' + 1);
        }

        for (char c : s2.toCharArray()) {
            val2 = val2 * 10 + (c - 'a' + 1);
        }

        for (char c : s3.toCharArray()) {
            val3 = val3 * 10 + (c - 'a' + 1);
        }

        return val1 + val2 == val3;
    }
}