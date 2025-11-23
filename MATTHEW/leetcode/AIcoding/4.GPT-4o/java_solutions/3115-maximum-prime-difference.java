class Solution {
    public int maxPrimeDifference(int[] nums) {
        boolean[] isPrime = new boolean[1001];
        for (int i = 2; i <= 1000; i++) isPrime[i] = true;
        for (int i = 2; i * i <= 1000; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= 1000; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i <= 1000; i++) {
            if (isPrime[i]) primes.add(i);
        }

        int maxDiff = -1;
        for (int num : nums) {
            int lower = -1, upper = -1;
            for (int prime : primes) {
                if (prime < num) lower = prime;
                if (prime > num && upper == -1) {
                    upper = prime;
                    break;
                }
            }
            if (lower != -1 && upper != -1) {
                maxDiff = Math.max(maxDiff, upper - lower);
            }
        }

        return maxDiff;
    }
}