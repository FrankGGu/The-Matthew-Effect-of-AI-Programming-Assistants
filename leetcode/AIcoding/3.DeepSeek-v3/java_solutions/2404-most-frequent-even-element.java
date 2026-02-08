class Solution {
    public int mostFrequentEven(int[] nums) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : nums) {
            if (num % 2 == 0) {
                frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
            }
        }
        if (frequencyMap.isEmpty()) {
            return -1;
        }
        int maxFrequency = -1;
        int result = Integer.MAX_VALUE;
        for (Map.Entry<Integer, Integer> entry : frequencyMap.entrySet()) {
            int num = entry.getKey();
            int frequency = entry.getValue();
            if (frequency > maxFrequency || (frequency == maxFrequency && num < result)) {
                maxFrequency = frequency;
                result = num;
            }
        }
        return result;
    }
}