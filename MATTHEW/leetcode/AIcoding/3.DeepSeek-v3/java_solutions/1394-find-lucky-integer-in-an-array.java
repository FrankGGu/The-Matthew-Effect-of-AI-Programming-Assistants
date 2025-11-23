class Solution {
    public int findLucky(int[] arr) {
        Map<Integer, Integer> frequencyMap = new HashMap<>();
        for (int num : arr) {
            frequencyMap.put(num, frequencyMap.getOrDefault(num, 0) + 1);
        }
        int maxLucky = -1;
        for (Map.Entry<Integer, Integer> entry : frequencyMap.entrySet()) {
            if (entry.getKey() == entry.getValue()) {
                if (entry.getKey() > maxLucky) {
                    maxLucky = entry.getKey();
                }
            }
        }
        return maxLucky;
    }
}