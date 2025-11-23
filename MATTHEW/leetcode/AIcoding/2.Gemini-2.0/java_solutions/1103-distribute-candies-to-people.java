class Solution {
    public int[] distributeCandies(int candies, int num_people) {
        int[] result = new int[num_people];
        int i = 0;
        int give = 1;
        while (candies > 0) {
            result[i % num_people] += Math.min(candies, give);
            candies -= give;
            give++;
            i++;
        }
        return result;
    }
}