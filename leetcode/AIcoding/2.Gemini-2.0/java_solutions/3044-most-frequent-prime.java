import java.util.*;

class Solution {
    public int mostFrequentPrime(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        Set<Integer> primes = new HashSet<>();
        for (int i = 10; i <= 99999; i++) {
            if (isPrime(i)) {
                primes.add(i);
            }
        }

        Map<Integer, Integer> counts = new HashMap<>();
        int maxFreq = 0;
        int mostFrequentPrime = -1;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                // Right
                int num = mat[i][j];
                for (int k = j + 1; k < n; k++) {
                    num = num * 10 + mat[i][k];
                    if (primes.contains(num)) {
                        counts.put(num, counts.getOrDefault(num, 0) + 1);
                        if (counts.get(num) > maxFreq || (counts.get(num) == maxFreq && num > mostFrequentPrime)) {
                            maxFreq = counts.get(num);
                            mostFrequentPrime = num;
                        }
                    }
                }

                // Down
                num = mat[i][j];
                for (int k = i + 1; k < m; k++) {
                    num = num * 10 + mat[k][j];
                    if (primes.contains(num)) {
                        counts.put(num, counts.getOrDefault(num, 0) + 1);
                        if (counts.get(num) > maxFreq || (counts.get(num) == maxFreq && num > mostFrequentPrime)) {
                            maxFreq = counts.get(num);
                            mostFrequentPrime = num;
                        }
                    }
                }

                // Diagonal Right Down
                num = mat[i][j];
                for (int k = 1; i + k < m && j + k < n; k++) {
                    num = num * 10 + mat[i + k][j + k];
                    if (primes.contains(num)) {
                        counts.put(num, counts.getOrDefault(num, 0) + 1);
                        if (counts.get(num) > maxFreq || (counts.get(num) == maxFreq && num > mostFrequentPrime)) {
                            maxFreq = counts.get(num);
                            mostFrequentPrime = num;
                        }
                    }
                }

                // Diagonal Left Down
                num = mat[i][j];
                for (int k = 1; i + k < m && j - k >= 0; k++) {
                    num = num * 10 + mat[i + k][j - k];
                    if (primes.contains(num)) {
                        counts.put(num, counts.getOrDefault(num, 0) + 1);
                        if (counts.get(num) > maxFreq || (counts.get(num) == maxFreq && num > mostFrequentPrime)) {
                            maxFreq = counts.get(num);
                            mostFrequentPrime = num;
                        }
                    }
                }
            }
        }

        return mostFrequentPrime;
    }

    private boolean isPrime(int n) {
        if (n < 2) return false;
        for (int i = 2; i * i <= n; i++) {
            if (n % i == 0) return false;
        }
        return true;
    }
}