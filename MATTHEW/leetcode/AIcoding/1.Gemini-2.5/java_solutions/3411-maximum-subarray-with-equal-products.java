import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

class Solution {

    private static List<Integer> primes;
    private static Map<Integer, Map<Integer, Integer>> numPrimeFactors;

    static {
        sieve(1000);
        numPrimeFactors = new HashMap<>();
        for (int i = 2; i <= 1000; i++) {
            numPrimeFactors.put(i, getFactors(i));
        }
    }

    private static void sieve(int limit) {
        boolean[] isPrime = new boolean[limit + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int p = 2; p * p <= limit; p++) {
            if (isPrime[p]) {
                for (int i = p * p; i <= limit; i += p)
                    isPrime[i] = false;
            }
        }
        primes = new ArrayList<>();
        for (int i = 2; i <= limit; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }
    }

    private static Map<Integer, Integer> getFactors(int n) {
        Map<Integer, Integer> factors = new HashMap<>();
        int tempN = n;
        for (int p : primes) {
            if (p * p > tempN) break;
            while (tempN % p == 0) {
                factors.put(p, factors.getOrDefault(p, 0) + 1);
                tempN /= p;
            }
        }
        if (tempN > 1) {
            factors.put(tempN, factors.getOrDefault(tempN, 0) + 1);
        }
        return factors;
    }

    private static class ProductInfo {
        boolean isZero;
        int sign;
        Map<Integer, Integer> primeFactors;

        ProductInfo(boolean isZero, int sign, Map<Integer, Integer> primeFactors) {
            this.isZero = isZero;
            this.sign = sign;
            this.primeFactors = primeFactors;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            ProductInfo that = (ProductInfo) o;
            if (isZero) {
                return that.isZero;
            } else {
                return !that.isZero && sign == that.sign && primeFactors.equals(that.primeFactors);
            }
        }

        @Override
        public int hashCode() {
            if (isZero) {
                return Boolean.hashCode(true);
            } else {
                return Objects.hash(false, sign, primeFactors);
            }
        }
    }

    public int getMaxLen(int[] nums) {
        int n = nums.length;
        int maxLen = 0;

        for (int k = 0; k < n - 1; k++) {
            Map<ProductInfo, Integer> leftProducts = new HashMap<>();
            Map<ProductInfo, Integer> rightProducts = new HashMap<>();

            int currentSign1 = 1;
            int currentZeros1 = 0;
            Map<Integer, Integer> currentFactors1 = new HashMap<>();

            for (int i = k; i >= 0; i--) {
                int num = nums[i];
                if (num == 0) {
                    currentZeros1++;
                } else {
                    if (num < 0) {
                        currentSign1 *= -1;
                    }
                    int absNum = Math.abs(num);
                    if (absNum > 1) {
                        Map<Integer, Integer> factors = numPrimeFactors.get(absNum);
                        for (Map.Entry<Integer, Integer> entry : factors.entrySet()) {
                            currentFactors1.put(entry.getKey(), currentFactors1.getOrDefault(entry.getKey(), 0) + entry.getValue());
                        }
                    }
                }

                ProductInfo info1;
                if (currentZeros1 > 0) {
                    info1 = new ProductInfo(true, 0, null);
                } else {
                    info1 = new ProductInfo(false, currentSign1, new HashMap<>(currentFactors1));
                }
                leftProducts.putIfAbsent(info1, i);
            }

            int currentSign2 = 1;
            int currentZeros2 = 0;
            Map<Integer, Integer> currentFactors2 = new HashMap<>();

            for (int j = k + 1; j < n; j++) {
                int num = nums[j];
                if (num == 0) {
                    currentZeros2++;
                } else {
                    if (num < 0) {
                        currentSign2 *= -1;
                    }
                    int absNum = Math.abs(num);
                    if (absNum > 1) {
                        Map<Integer, Integer> factors = numPrimeFactors.get(absNum);
                        for (Map.Entry<Integer, Integer> entry : factors.entrySet()) {
                            currentFactors2.put(entry.getKey(), currentFactors2.getOrDefault(entry.getKey(), 0) + entry.getValue());
                        }
                    }
                }

                ProductInfo info2;
                if (currentZeros2 > 0) {
                    info2 = new ProductInfo(true, 0, null);
                } else {
                    info2 = new ProductInfo(false, currentSign2, new HashMap<>(currentFactors2));
                }
                rightProducts.put(info2, j);
            }

            for (Map.Entry<ProductInfo, Integer> entry1 : leftProducts.entrySet()) {
                ProductInfo info1 = entry1.getKey();
                int i = entry1.getValue();

                if (rightProducts.containsKey(info1)) {
                    int j = rightProducts.get(info1);
                    maxLen = Math.max(maxLen, j - i + 1);
                }
            }
        }

        return maxLen;
    }
}