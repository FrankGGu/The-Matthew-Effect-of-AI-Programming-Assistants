class Solution {
    public char[][] rotateTheBox(char[][] box) {
        int m = box.length;
        int n = box[0].length;
        char[][] rotated = new char[n][m];

        for (int i = 0; i < m; i++) {
            int pos = n - 1;
            for (int j = n - 1; j >= 0; j--) {
                if (box[i][j] == '#') {
                    box[i][j] = '.';
                    box[i][pos] = '#';
                    pos--;
                } else if (box[i][j] == '*') {
                    pos = j - 1;
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                rotated[j][m - 1 - i] = box[i][j];
            }
        }

        return rotated;
    }
}