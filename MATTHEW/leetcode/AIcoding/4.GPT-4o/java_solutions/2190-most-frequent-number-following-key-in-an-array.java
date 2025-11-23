class Solution {
    public int mostFrequent(int[] nums, int key) {
        Map<Integer, Integer> frequency = new HashMap<>();
        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] == key) {
                frequency.put(nums[i + 1], frequency.getOrDefault(nums[i + 1], 0) + 1);
            }
        }
        int maxFreq = 0;
        int result = -1;
        for (Map.Entry<Integer, Integer> entry : frequency.entrySet()) {
            if (entry.getValue() > maxFreq) {
                maxFreq = entry.getValue();
                result = entry.getKey();
            }
        }
        return result;
    }
}