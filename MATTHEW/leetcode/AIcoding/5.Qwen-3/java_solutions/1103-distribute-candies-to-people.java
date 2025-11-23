public class Solution {
    public int[] distributeCandies(int candies, int numPeople) {
        int[] result = new int[numPeople];
        int i = 0;
        int give = 1;
        while (candies > 0) {
            result[i % numPeople] += Math.min(give, candies);
            candies -= give;
            give++;
            i++;
        }
        return result;
    }
}