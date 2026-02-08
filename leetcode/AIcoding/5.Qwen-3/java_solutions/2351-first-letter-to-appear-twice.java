public class Solution {
    public char repeatedCharacter(String s) {
        int[] seen = new int[26];
        for (char c : s.toCharArray()) {
            int index = c - 'a';
            seen[index]++;
            if (seen[index] == 2) {
                return c;
            }
        }
        return ' ';
    }
}