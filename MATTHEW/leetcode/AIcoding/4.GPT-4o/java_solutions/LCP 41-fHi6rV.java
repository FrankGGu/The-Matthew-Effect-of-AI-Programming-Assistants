public class Solution {
    public int[] flipChess(String[] chess) {
        int m = chess.length, n = chess[0].length();
        int[] directions = {-1, 0, 1, 0, -1};
        int maxFlips = 0;
        int[] result = new int[2];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (chess[i].charAt(j) == '.') {
                    int flips = 0;
                    for (int d = 0; d < 4; d++) {
                        int x = i + directions[d];
                        int y = j + directions[d + 1];
                        while (x >= 0 && x < m && y >= 0 && y < n && chess[x].charAt(y) == 'W') {
                            flips++;
                            x += directions[d];
                            y += directions[d + 1];
                        }
                        if (x >= 0 && x < m && y >= 0 && y < n && chess[x].charAt(y) == 'B') {
                            flips++;
                        }
                    }
                    if (flips > maxFlips) {
                        maxFlips = flips;
                        result[0] = i;
                        result[1] = j;
                    }
                }
            }
        }
        return result;
    }
}