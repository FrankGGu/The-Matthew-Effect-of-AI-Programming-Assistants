class Solution {
    public int percentageLetter(String s, char letter) {
        int count = 0;
        for (char c : s.toCharArray()) {
            if (c == letter) {
                count++;
            }
        }
        if (s.length() == 0) {
            return 0;
        }
        return (count * 100) / s.length();
    }
}