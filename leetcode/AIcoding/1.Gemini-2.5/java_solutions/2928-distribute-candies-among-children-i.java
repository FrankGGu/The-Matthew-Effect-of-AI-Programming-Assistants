class Solution {
    public int distributeCandies(int candies, int limit) {
        int count = 0;
        for (int x1 = 0; x1 <= candies; x1++) {
            if (x1 > limit) {
                continue;
            }
            for (int x2 = 0; x2 <= candies - x1; x2++) {
                if (x2 > limit) {
                    continue;
                }
                int x3 = candies - x1 - x2;
                if (x3 >= 0 && x3 <= limit) {
                    count++;
                }
            }
        }
        return count;
    }
}