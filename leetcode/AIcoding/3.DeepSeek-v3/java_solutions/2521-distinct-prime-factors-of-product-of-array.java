class Solution {
    public int distinctPrimeFactors(int[] nums) {
        Set<Integer> primeFactors = new HashSet<>();
        for (int num : nums) {
            int n = num;
            for (int i = 2; i * i <= n; i++) {
                while (n % i == 0) {
                    primeFactors.add(i);
                    n /= i;
                }
            }
            if (n > 1) {
                primeFactors.add(n);
            }
        }
        return primeFactors.size();
    }
}