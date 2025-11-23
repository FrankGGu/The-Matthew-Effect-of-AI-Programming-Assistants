class Solution {
    public int minimumMoves(String s) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; ) {
            if (s.charAt(i) == 'X') {
                count++;
                i += 3;
            } else {
                i++;
            }
        }
        return count;
    }
}