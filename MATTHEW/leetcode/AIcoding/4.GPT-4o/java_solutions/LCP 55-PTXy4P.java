class Solution {
    public int maxFruitCount(int[] fruits) {
        int n = fruits.length;
        if (n == 0) return 0;

        int maxCount = 0;
        int left = 0;
        Map<Integer, Integer> fruitMap = new HashMap<>();

        for (int right = 0; right < n; right++) {
            fruitMap.put(fruits[right], fruitMap.getOrDefault(fruits[right], 0) + 1);

            while (fruitMap.size() > 2) {
                fruitMap.put(fruits[left], fruitMap.get(fruits[left]) - 1);
                if (fruitMap.get(fruits[left]) == 0) {
                    fruitMap.remove(fruits[left]);
                }
                left++;
            }

            maxCount = Math.max(maxCount, right - left + 1);
        }

        return maxCount;
    }
}