class Solution {
    public int maxEqualFreq(int[] nums) {
        Map<Integer, Integer> countMap = new HashMap<>();
        Map<Integer, Integer> freqMap = new HashMap<>();
        int res = 0;
        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            if (countMap.containsKey(num)) {
                int oldCount = countMap.get(num);
                freqMap.put(oldCount, freqMap.get(oldCount) - 1);
                if (freqMap.get(oldCount) == 0) {
                    freqMap.remove(oldCount);
                }
            }
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
            int newCount = countMap.get(num);
            freqMap.put(newCount, freqMap.getOrDefault(newCount, 0) + 1);

            boolean condition1 = freqMap.size() == 1 && (freqMap.containsKey(1) || freqMap.get(newCount) == 1);
            boolean condition2 = freqMap.size() == 2 && freqMap.containsKey(1) && freqMap.get(1) == 1;
            boolean condition3 = freqMap.size() == 2 && freqMap.containsKey(newCount - 1) && freqMap.get(newCount - 1) == 1;

            if (condition1 || condition2 || condition3) {
                res = i + 1;
            }
        }
        return res;
    }
}