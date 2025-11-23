class Solution {
    public int countAsterisks(String s) {
        int count = 0;
        boolean insidePair = false;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '|') {
                insidePair = !insidePair;
            } else if (s.charAt(i) == '*' && !insidePair) {
                count++;
            }
        }
        return count;
    }
}