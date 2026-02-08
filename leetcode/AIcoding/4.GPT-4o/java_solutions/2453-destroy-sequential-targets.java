class Solution {
    public int destroyTargets(int[] targets, int space) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int target : targets) {
            int key = target % space;
            countMap.put(key, countMap.getOrDefault(key, 0) + 1);
        }

        int maxCount = 0;
        int result = Integer.MAX_VALUE;

        for (Map.Entry<Integer, Integer> entry : countMap.entrySet()) {
            int key = entry.getKey();
            int count = entry.getValue();
            if (count > maxCount || (count == maxCount && key < result)) {
                maxCount = count;
                result = key;
            }
        }

        return result;
    }
}