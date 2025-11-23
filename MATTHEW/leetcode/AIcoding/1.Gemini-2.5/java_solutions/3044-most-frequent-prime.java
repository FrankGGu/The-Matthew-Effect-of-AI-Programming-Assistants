import java.util.HashMap;
import java.util.Map;

class Solution {

    private boolean isPrime(int num) {
        if (num < 2) {
            return false;
        }
        if (num == 2 || num == 3) {
            return true;
        }
        if (num % 2 == 0 || num % 3 == 0) {
            return false;
        }
        for (int i = 5; i * i <= num; i = i + 6) {
            if (num % i == 0 || num % (i + 2) == 0) {
                return false;
            }
        }
        return true;
    }

    public int mostFrequentPrime(int[][] grid) {
        Map<Integer, Integer> primeCounts = new HashMap<>();
        int m = grid.length;
        int n = grid[0].length;

        int[] dr = {-1, -1, -1, 0, 0, 1, 1, 1};
        int[] dc = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (grid[r][c] == 0) {
                    continue; 
                }

                for (int dir = 0; dir < 8; dir++) {
                    int currentNum = grid[r][c];
                    int nr = r + dr[dir];
                    int nc = c + dc[dir];

                    while (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                        currentNum = currentNum * 10 + grid[nr][nc];

                        if (isPrime(currentNum)) {
                            primeCounts.put(currentNum, primeCounts.getOrDefault(currentNum, 0) + 1);
                        }

                        nr += dr[dir];
                        nc += dc[dir];
                    }
                }
            }
        }

        int maxFreq = 0;
        int result = -1; 

        for (Map.Entry<Integer, Integer> entry : primeCounts.entrySet()) {
            int prime = entry.getKey();
            int freq = entry.getValue();

            if (freq > maxFreq) {
                maxFreq = freq;
                result = prime;
            } else if (freq == maxFreq) {
                result = Math.max(result, prime);
            }
        }

        return result;
    }
}