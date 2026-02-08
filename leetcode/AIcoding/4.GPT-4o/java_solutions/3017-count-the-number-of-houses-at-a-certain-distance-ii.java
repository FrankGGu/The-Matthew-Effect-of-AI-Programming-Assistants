public class Solution {
    public int countHouses(int[][] houses, int distance) {
        int count = 0;
        for (int[] house : houses) {
            if (house[1] <= distance) {
                count++;
            }
        }
        return count;
    }
}