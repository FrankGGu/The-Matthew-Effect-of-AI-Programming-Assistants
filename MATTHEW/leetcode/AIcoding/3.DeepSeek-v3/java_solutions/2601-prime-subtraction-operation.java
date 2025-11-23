class Solution {
    public boolean primeSubOperation(int[] nums) {
        List<Integer> primes = getPrimes(1000);
        int n = nums.length;
        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] >= nums[i + 1]) {
                int target = nums[i] - nums[i + 1];
                int left = 0, right = primes.size() - 1;
                int bestPrime = -1;
                while (left <= right) {
                    int mid = left + (right - left) / 2;
                    if (primes.get(mid) > target && primes.get(mid) < nums[i]) {
                        bestPrime = primes.get(mid);
                        right = mid - 1;
                    } else if (primes.get(mid) <= target) {
                        left = mid + 1;
                    } else {
                        right = mid - 1;
                    }
                }
                if (bestPrime == -1) {
                    return false;
                }
                nums[i] -= bestPrime;
            }
        }
        return true;
    }

    private List<Integer> getPrimes(int max) {
        boolean[] isPrime = new boolean[max + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= max; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= max; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        List<Integer> primes = new ArrayList<>();
        for (int i = 2; i <= max; i++) {
            if (isPrime[i]) {
                primes.add(i);
            }
        }
        return primes;
    }
}