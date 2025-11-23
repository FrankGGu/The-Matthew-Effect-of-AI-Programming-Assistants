class Solution {
    public int[] distributeCandies(int candies, int num_people) {
        int[] result = new int[num_people];
        int currentCandyAmount = 1;
        int personIndex = 0;

        while (candies > 0) {
            int giveAmount = Math.min(currentCandyAmount, candies);
            result[personIndex] += giveAmount;
            candies -= giveAmount;
            currentCandyAmount++;
            personIndex = (personIndex + 1) % num_people;
        }

        return result;
    }
}