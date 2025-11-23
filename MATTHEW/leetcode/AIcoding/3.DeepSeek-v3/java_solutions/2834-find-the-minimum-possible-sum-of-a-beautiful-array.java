class Solution {
    public long minimumPossibleSum(int n, int target) {
        long sum = 0;
        int num = 1;
        Set<Integer> used = new HashSet<>();

        for (int i = 0; i < n; ) {
            if (!used.contains(target - num)) {
                sum += num;
                used.add(num);
                i++;
            }
            num++;
        }

        return sum;
    }
}