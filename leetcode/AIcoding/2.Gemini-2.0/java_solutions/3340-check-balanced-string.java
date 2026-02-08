class Solution {
    public boolean checkBalancedString(String s) {
        int n = s.length();
        int avg = n / 4;
        int[] count = new int[4];
        for (char c : s.toCharArray()) {
            if (c == 'Q') count[0]++;
            else if (c == 'W') count[1]++;
            else if (c == 'E') count[2]++;
            else count[3]++;
        }

        int q = Math.max(0, count[0] - avg);
        int w = Math.max(0, count[1] - avg);
        int e = Math.max(0, count[2] - avg);
        int r = Math.max(0, count[3] - avg);

        return q + w + e + r <= n / 4 * 4 && q + w + e + r >=0;
    }
}