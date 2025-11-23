class Solution {
    public boolean canBeEmpty(String s) {
        int count = 0;
        for (char c : s.toCharArray()) {
            if (c == 'A') {
                count++;
            } else if (c == 'B') {
                count--;
            }
        }
        return count == 0 && s.length() % 2 == 0;
    }
}