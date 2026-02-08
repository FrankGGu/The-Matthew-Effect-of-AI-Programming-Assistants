class Solution {
    public int totalFruits(int[] fruits) {
        int left = 0, right = 0, maxFruits = 0;
        Map<Integer, Integer> fruitCount = new HashMap<>();

        while (right < fruits.length) {
            fruitCount.put(fruits[right], fruitCount.getOrDefault(fruits[right], 0) + 1);

            while (fruitCount.size() > 2) {
                fruitCount.put(fruits[left], fruitCount.get(fruits[left]) - 1);
                if (fruitCount.get(fruits[left]) == 0) {
                    fruitCount.remove(fruits[left]);
                }
                left++;
            }

            maxFruits = Math.max(maxFruits, right - left + 1);
            right++;
        }

        return maxFruits;
    }
}