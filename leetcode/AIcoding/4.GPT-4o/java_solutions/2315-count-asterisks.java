class Solution {
    public int countAsterisks(String s) {
        int count = 0;
        boolean inBarredSection = false;

        for (char c : s.toCharArray()) {
            if (c == '|') {
                inBarredSection = !inBarredSection;
            } else if (c == '*' && !inBarredSection) {
                count++;
            }
        }

        return count;
    }
}