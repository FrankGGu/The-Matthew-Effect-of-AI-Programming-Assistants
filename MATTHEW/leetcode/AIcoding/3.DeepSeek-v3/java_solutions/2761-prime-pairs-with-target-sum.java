class Solution {
    public List<List<Integer>> findPrimePairs(int n) {
        List<List<Integer>> result = new ArrayList<>();
        boolean[] isPrime = sieveOfEratosthenes(n);
        for (int i = 2; i <= n / 2; i++) {
            int j = n - i;
            if (isPrime[i] && isPrime[j]) {
                result.add(Arrays.asList(i, j));
            }
        }
        return result;
    }

    private boolean[] sieveOfEratosthenes(int n) {
        boolean[] isPrime = new boolean[n + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = false;
        isPrime[1] = false;
        for (int i = 2; i * i <= n; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        return isPrime;
    }
}