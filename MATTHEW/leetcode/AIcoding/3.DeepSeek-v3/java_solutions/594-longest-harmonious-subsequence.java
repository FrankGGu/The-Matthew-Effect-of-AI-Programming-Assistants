class Solution {
    public int findLHS(int[] nums) {
        Map<Integer, Integer> freqMap = new HashMap<>();
        for (int num : nums) {
            freqMap.put(num, freqMap.getOrDefault(num, 0) + 1);
        }
        int maxLen = 0;
        for (int key : freqMap.keySet()) {
            if (freqMap.containsKey(key + 1)) {
                maxLen = Math.max(maxLen, freqMap.get(key) + freqMap.get(key + 1));
            }
        }
        return maxLen;
    }
}