class Solution {
    public int[] distributeCandies(int candies, int num_people) {
        int[] result = new int[num_people];
        int current = 1;
        int index = 0;
        while (candies > 0) {
            if (candies >= current) {
                result[index] += current;
                candies -= current;
            } else {
                result[index] += candies;
                candies = 0;
            }
            current++;
            index = (index + 1) % num_people;
        }
        return result;
    }
}