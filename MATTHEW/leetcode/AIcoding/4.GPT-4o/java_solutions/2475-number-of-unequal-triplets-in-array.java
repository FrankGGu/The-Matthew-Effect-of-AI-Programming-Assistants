class Solution {
    public int unequalTriplets(int[] nums) {
        int count = 0;
        int n = nums.length;
        Map<Integer, Integer> freq = new HashMap<>();

        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        List<Integer> unique = new ArrayList<>(freq.keySet());
        int m = unique.size();

        for (int i = 0; i < m; i++) {
            for (int j = i + 1; j < m; j++) {
                for (int k = j + 1; k < m; k++) {
                    count += freq.get(unique.get(i)) * freq.get(unique.get(j)) * freq.get(unique.get(k));
                }
            }
        }

        return count;
    }
}