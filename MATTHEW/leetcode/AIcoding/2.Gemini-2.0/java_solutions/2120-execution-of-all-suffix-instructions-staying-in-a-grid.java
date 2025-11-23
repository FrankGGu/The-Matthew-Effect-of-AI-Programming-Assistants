class Solution {
    public int[] executeInstructions(int n, int[] startPos, String s) {
        int[] result = new int[s.length()];
        for (int i = 0; i < s.length(); i++) {
            int x = startPos[0];
            int y = startPos[1];
            int count = 0;
            for (int j = i; j < s.length(); j++) {
                char instruction = s.charAt(j);
                if (instruction == 'R') {
                    y++;
                } else if (instruction == 'L') {
                    y--;
                } else if (instruction == 'U') {
                    x--;
                } else {
                    x++;
                }
                if (x < 0 || x >= n || y < 0 || y >= n) {
                    break;
                }
                count++;
            }
            result[i] = count;
        }
        return result;
    }
}