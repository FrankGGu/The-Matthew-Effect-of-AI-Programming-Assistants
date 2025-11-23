class Solution {
    public List<Integer> findLonely(int[] nums) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : nums) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }

        List<Integer> result = new ArrayList<>();
        for (int num : nums) {
            if (frequencyMap.get(num) == 1 && !frequencyMap.containsKey(num - 1) && !frequencyMap.containsKey(num + 1)) {
                result.add(num);
            }
        }
        return result;
    }
}