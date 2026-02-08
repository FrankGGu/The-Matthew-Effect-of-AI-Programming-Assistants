class Solution {
    public int sumImbalanceNumbers(int[] nums) {
        int n = nums.length;
        int total = 0;

        for (int i = 0; i < n; i++) {
            TreeSet<Integer> set = new TreeSet<>();
            int imbalance = 0;
            for (int j = i; j < n; j++) {
                int num = nums[j];
                if (set.contains(num)) {
                    total += imbalance;
                    continue;
                }
                set.add(num);
                Integer lower = set.lower(num);
                Integer higher = set.higher(num);
                if (lower != null && higher != null) {
                    if (higher - lower > 1) {
                        imbalance--;
                    }
                }
                if (lower != null) {
                    if (num - lower > 1) {
                        imbalance++;
                    }
                }
                if (higher != null) {
                    if (higher - num > 1) {
                        imbalance++;
                    }
                }
                total += imbalance;
            }
        }
        return total;
    }
}