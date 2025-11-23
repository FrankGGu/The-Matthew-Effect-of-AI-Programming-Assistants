class Solution {
    private static final int[][] DIRECTIONS = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

    public int mostFrequentPrime(int[][] mat) {
        Map<Integer, Integer> primeFrequency = new HashMap<>();
        int m = mat.length;
        int n = mat[0].length;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int[] dir : DIRECTIONS) {
                    int x = i, y = j;
                    int num = 0;
                    while (x >= 0 && x < m && y >= 0 && y < n) {
                        num = num * 10 + mat[x][y];
                        if (num > 10 && isPrime(num)) {
                            primeFrequency.put(num, primeFrequency.getOrDefault(num, 0) + 1);
                        }
                        x += dir[0];
                        y += dir[1];
                    }
                }
            }
        }

        int maxFreq = 0;
        int result = -1;
        for (Map.Entry<Integer, Integer> entry : primeFrequency.entrySet()) {
            if (entry.getValue() > maxFreq || (entry.getValue() == maxFreq && entry.getKey() > result)) {
                maxFreq = entry.getValue();
                result = entry.getKey();
            }
        }

        return result;
    }

    private boolean isPrime(int num) {
        if (num <= 1) return false;
        if (num == 2) return true;
        if (num % 2 == 0) return false;
        for (int i = 3; i * i <= num; i += 2) {
            if (num % i == 0) return false;
        }
        return true;
    }
}