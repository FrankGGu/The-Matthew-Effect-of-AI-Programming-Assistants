class Solution {
    public int mostFrequent(int[] nums, int key) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        int maxFrequency = 0;
        int result = 0;

        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] == key) {
                int target = nums[i + 1];
                frequencyMap.put(target, frequencyMap.getOrDefault(target, 0) + 1);

                if (frequencyMap.get(target) > maxFrequency) {
                    maxFrequency = frequencyMap.get(target);
                    result = target;
                }
            }
        }

        return result;
    }
}