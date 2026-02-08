class Solution {
    public int findValidSplit(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> left = new HashMap<>();
        Map<Integer, Integer> right = new HashMap<>();

        for (int num : nums) {
            for (int p : getPrimeFactors(num)) {
                right.put(p, right.getOrDefault(p, 0) + 1);
            }
        }

        int common = 0;
        for (int i = 0; i < n - 1; i++) {
            int num = nums[i];
            for (int p : getPrimeFactors(num)) {
                left.put(p, left.getOrDefault(p, 0) + 1);
                right.put(p, right.get(p) - 1);
                if (left.get(p) == 1 && right.get(p) == 0) {
                    common++;
                }
                if (left.get(p) > 1 && right.get(p) == 0) {
                    common--;
                }
            }
            if (common == left.size()) {
                return i;
            }
        }
        return -1;
    }

    private Set<Integer> getPrimeFactors(int num) {
        Set<Integer> factors = new HashSet<>();
        if (num == 1) {
            return factors;
        }
        for (int i = 2; i * i <= num; i++) {
            while (num % i == 0) {
                factors.add(i);
                num /= i;
            }
        }
        if (num > 1) {
            factors.add(num);
        }
        return factors;
    }
}