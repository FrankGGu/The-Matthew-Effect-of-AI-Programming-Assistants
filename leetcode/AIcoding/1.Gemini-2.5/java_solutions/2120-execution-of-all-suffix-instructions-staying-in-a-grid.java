class Solution {
    public int[] executeInstructions(int n, int[] startPos, String s) {
        int[] ans = new int[s.length()];

        for (int i = 0; i < s.length(); i++) {
            int currentRow = startPos[0];
            int currentCol = startPos[1];
            int count = 0;

            for (int j = i; j < s.length(); j++) {
                char instruction = s.charAt(j);

                if (instruction == 'L') {
                    currentCol--;
                } else if (instruction == 'R') {
                    currentCol++;
                } else if (instruction == 'U') {
                    currentRow--;
                } else if (instruction == 'D') {
                    currentRow++;
                }

                if (currentRow < 0 || currentRow >= n || currentCol < 0 || currentCol >= n) {
                    break; 
                }
                count++;
            }
            ans[i] = count;
        }

        return ans;
    }
}