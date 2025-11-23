class Solution {
    public int destroyTargets(int[] nums, int space) {
        Map<Integer, Integer> countMap = new HashMap<>();
        Map<Integer, Integer> minNumMap = new HashMap<>();

        for (int num : nums) {
            int remainder = num % space;
            countMap.put(remainder, countMap.getOrDefault(remainder, 0) + 1);
            if (!minNumMap.containsKey(remainder) || num < minNumMap.get(remainder)) {
                minNumMap.put(remainder, num);
            }
        }

        int maxCount = 0;
        int result = Integer.MAX_VALUE;

        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            int count = entry.getValue();
            int remainder = entry.getKey();
            if (count > maxCount) {
                maxCount = count;
                result = minNumMap.get(remainder);
            } else if (count == maxCount) {
                if (minNumMap.get(remainder) < result) {
                    result = minNumMap.get(remainder);
                }
            }
        }

        return result;
    }
}