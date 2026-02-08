class Solution {
    public int minimumTime(String s) {
        int n = s.length();
        int time = 0;

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '1') {
                time += 1;
            } else if (s.charAt(i) == '0') {
                time += 2;
            }
        }

        return time;
    }
}