public class Solution {
    public boolean canAliceWin(String s) {
        int vowels = 0;
        for (char c : s.toCharArray()) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowels++;
            }
        }
        return vowels > 0 && vowels % 2 == 1;
    }
}