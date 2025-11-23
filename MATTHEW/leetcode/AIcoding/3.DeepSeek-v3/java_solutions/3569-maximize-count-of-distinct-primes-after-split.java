class Solution {
    public int distinctPrimeFactors(int[] nums) {
        Set<Integer> primeFactors = new HashSet<>();
        for (int num : nums) {
            addPrimeFactors(num, primeFactors);
        }
        return primeFactors.size();
    }

    private void addPrimeFactors(int num, Set<Integer> primeFactors) {
        for (int i = 2; i * i <= num; i++) {
            while (num % i == 0) {
                primeFactors.add(i);
                num /= i;
            }
        }
        if (num > 1) {
            primeFactors.add(num);
        }
    }
}