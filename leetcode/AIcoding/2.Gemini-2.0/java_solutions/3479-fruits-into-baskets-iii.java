class Solution {
    public int totalFruit(int[] fruits) {
        int maxLen = 0;
        int left = 0;
        int right = 0;
        int[] count = new int[fruits.length];
        int types = 0;

        while (right < fruits.length) {
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

            maxLen = Math.max(maxLen, right - left + 1);
            right++;
        }

        return maxLen;
    }
}