class Solution {
    public int countMaxFrequency(int[] nums) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        int maxFrequency = 0;

        for (int num : nums) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
            maxFrequency = Math.max(maxFrequency, frequencyMap.get(num));
        }

        return (int) frequencyMap.values().stream().filter(freq -> freq == maxFrequency).count();
    }
}