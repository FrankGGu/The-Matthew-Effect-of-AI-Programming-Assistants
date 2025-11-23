class Solution {
    public char[][] rotateTheBox(char[][] box) {
        int m = box.length;
        int n = box[0].length;
        char[][] rotatedBox = new char[n][m];

        for (int i = 0; i < m; i++) {
            int lastEmpty = n - 1;
            for (int j = n - 1; j >= 0; j--) {
                if (box[i][j] == '*') {
                    lastEmpty = j - 1;
                } else if (box[i][j] == '#') {
                    box[i][j] = '.';
                    box[i][lastEmpty] = '#';
                    lastEmpty--;
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                rotatedBox[j][m - 1 - i] = box[i][j];
            }
        }

        return rotatedBox;
    }
}