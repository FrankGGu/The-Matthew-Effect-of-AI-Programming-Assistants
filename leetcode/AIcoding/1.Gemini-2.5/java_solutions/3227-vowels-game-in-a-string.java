class Solution {
    public boolean vowelsGame(String s) {
        int vowelCount = 0;
        for (char c : s.toCharArray()) {
            if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                vowelCount++;
            }
        }
        return vowelCount % 2 != 0;
    }
}