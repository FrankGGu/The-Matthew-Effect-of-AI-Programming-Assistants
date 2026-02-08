class Solution {
    public int minGroupsForValidAssignment(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        List<Integer> counts = new ArrayList<>(freq.values());
        Collections.sort(counts);
        int minCount = counts.get(0);

        for (int k = minCount + 1; k >= 1; k--) {
            int groups = 0;
            boolean valid = true;
            for (int count : counts) {
                int q = count / k;
                int r = count % k;
                if (q >= r) {
                    groups += q;
                } else {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                return groups;
            }
        }
        return nums.length;
    }
}