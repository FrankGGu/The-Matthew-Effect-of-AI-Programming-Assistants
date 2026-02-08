class Solution {
    public int[] numberOfPairs(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }
        int pairs = 0;
        int leftovers = 0;
        for (int count : countMap.values()) {
            pairs += count / 2;
            leftovers += count % 2;
        }
        return new int[]{pairs, leftovers};
    }
}