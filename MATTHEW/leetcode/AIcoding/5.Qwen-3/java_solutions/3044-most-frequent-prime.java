public class Solution {

import java.util.*;

public class Solution {
    public int mostFrequentPrime(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        Map<Integer, Integer> primeCount = new HashMap<>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                for (int di = -1; di <= 1; di++) {
                    for (int dj = -1; dj <= 1; dj++) {
                        if (di == 0 && dj == 0) continue;
                        int x = i + di;
                        int y = j + dj;
                        int num = grid[i][j];
                        while (x >= 0 && x < rows && y >= 0 && y < cols) {
                            num = num * 10 + grid[x][y];
                            primeCount.put(num, primeCount.getOrDefault(num, 0) + 1);
                            x += di;
                            y += dj;
                        }
                    }
                }
            }
        }

        int maxFreq = 0;
        int result = -1;
        for (Map.Entry<Integer, Integer> entry : primeCount.entrySet()) {
            if (isPrime(entry.getKey())) {
                int freq = entry.getValue();
                if (freq > maxFreq || (freq == maxFreq && entry.getKey() < result)) {
                    maxFreq = freq;
                    result = entry.getKey();
                }
            }
        }
        return result;
    }

    private boolean isPrime(int n) {
        if (n < 2) return false;
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) return false;
        }
        return true;
    }
}
}