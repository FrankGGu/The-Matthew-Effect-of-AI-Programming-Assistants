class Solution {
    public int countAsterisks(String s) {
        int count = 0;
        boolean inPair = false;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '|') {
                inPair = !inPair;
            } else if (c == '*' && !inPair) {
                count++;
            }
        }
        return count;
    }
}