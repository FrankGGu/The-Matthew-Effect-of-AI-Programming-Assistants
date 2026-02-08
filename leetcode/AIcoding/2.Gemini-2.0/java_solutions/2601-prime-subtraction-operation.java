class Solution {
    public boolean primeSubOperation(int[] nums) {
        int n = nums.length;
        boolean[] isPrime = new boolean[1001];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int p = 2; p * p <= 1000; p++) {
            if (isPrime[p]) {
                for (int i = p * p; i <= 1000; i += p)
                    isPrime[i] = false;
            }
        }

        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i < 1001; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }

        int prev = 0;
        for (int i = 0; i < n; i++) {
            int num = nums[i];
            int sub = 0;
            for (int prime : primes) {
                if (num - prime > prev) {
                    sub = prime;
                } else {
                    break;
                }
            }
            if (sub > 0) {
                num -= sub;
            }
            if (num <= prev) {
                return false;
            }
            prev = num;
        }

        return true;
    }
}