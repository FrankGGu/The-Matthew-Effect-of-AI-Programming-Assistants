import java.util.HashMap;
import java.util.Map;

class Solution {
    public int totalFruit(int[] fruits) {
        if (fruits == null || fruits.length == 0) {
            return 0;
        }

        int k = 3; // Interpreting "Fruits Into Baskets III" as allowing at most 3 distinct fruit types
        int left = 0;
        int maxLength = 0;
        Map<Integer, Integer> fruitCounts = new HashMap<>();

        for (int right = 0; right < fruits.length; right++) {
            fruitCounts.put(fruits[right], fruitCounts.getOrDefault(fruits[right], 0) + 1);

            while (fruitCounts.size() > k) {
                fruitCounts.put(fruits[left], fruitCounts.get(fruits[left]) - 1);
                if (fruitCounts.get(fruits[left]) == 0) {
                    fruitCounts.remove(fruits[left]);
                }
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
        }
        return maxLength;
    }
}