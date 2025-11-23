class Solution {
    public char[][] rotateTheBox(char[][] box) {
        int m = box.length;
        int n = box[0].length;
        char[][] rotated = new char[n][m];

        for (int j = 0; j < n; j++) {
            for (int i = m - 1; i >= 0; i--) {
                if (box[i][j] == '#') {
                    rotated[j][n - 1 - i] = '#';
                } else if (box[i][j] == '*') {
                    rotated[j][n - 1 - i] = '*';
                } else {
                    rotated[j][n - 1 - i] = '.';
                }
            }
        }

        for (int j = 0; j < n; j++) {
            int count = 0;
            for (int i = m - 1; i >= 0; i--) {
                if (rotated[j][i] == '#') {
                    count++;
                } else if (rotated[j][i] == '*') {
                    for (int k = 0; k < count; k++) {
                        rotated[j][i + k + 1] = '#';
                    }
                    count = 0;
                }
            }
            for (int k = 0; k < count; k++) {
                rotated[j][k] = '#';
            }
        }

        return rotated;
    }
}