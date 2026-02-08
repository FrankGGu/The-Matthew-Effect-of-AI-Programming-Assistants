class Solution {
    public int totalFruit(int[] fruits) {
        int maxFruits = 0;
        int left = 0;
        int[] count = new int[fruits.length];
        int types = 0;

        for (int right = 0; right < fruits.length; right++) {
            if (count[fruits[right]] == 0) {
                types++;
            }
            count[fruits[right]]++;

            while (types > 2) {
                count[fruits[left]]--;
                if (count[fruits[left]] == 0) {
                    types--;
                }
                left++;
            }

            maxFruits = Math.max(maxFruits, right - left + 1);
        }

        return maxFruits;
    }
}