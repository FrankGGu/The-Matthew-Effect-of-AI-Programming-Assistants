public class Solution {
    public int countSubstrings(String s, char c) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == c) {
                count++;
            }
        }
        return count * (count + 1) / 2;
    }
}