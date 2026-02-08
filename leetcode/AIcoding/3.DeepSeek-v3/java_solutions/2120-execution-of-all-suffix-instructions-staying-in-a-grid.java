class Solution {
    public int[] executeInstructions(int n, int[] startPos, String s) {
        int m = s.length();
        int[] result = new int[m];
        for (int i = 0; i < m; i++) {
            int x = startPos[0];
            int y = startPos[1];
            int count = 0;
            for (int j = i; j < m; j++) {
                char c = s.charAt(j);
                if (c == 'L') y--;
                else if (c == 'R') y++;
                else if (c == 'U') x--;
                else if (c == 'D') x++;
                if (x < 0 || x >= n || y < 0 || y >= n) break;
                count++;
            }
            result[i] = count;
        }
        return result;
    }
}