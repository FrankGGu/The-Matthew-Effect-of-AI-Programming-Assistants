class Solution {
    public int comfortableHumidity(int[] operations) {
        TreeSet<Integer> set = new TreeSet<>();
        set.add(0);
        set.add(Integer.MAX_VALUE);
        int maxGap = 0;
        int[] res = new int[operations.length];

        for (int i = 0; i < operations.length; i++) {
            int num = operations[i];
            Integer lower = set.lower(num);
            Integer higher = set.higher(num);

            if (lower != null && higher != null) {
                maxGap = Math.max(maxGap, higher - lower);
            }

            set.add(num);
            res[i] = maxGap;
        }

        int sum = 0;
        for (int num : res) {
            sum += num;
        }
        return sum;
    }
}