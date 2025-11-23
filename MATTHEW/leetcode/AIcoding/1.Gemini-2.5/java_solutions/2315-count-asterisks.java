class Solution {
    public int countAsterisks(String s) {
        int count = 0;
        int barCount = 0;

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '|') {
                barCount++;
            } else if (c == '*') {
                if (barCount % 2 == 0) {
                    count++;
                }
            }
        }
        return count;
    }
}