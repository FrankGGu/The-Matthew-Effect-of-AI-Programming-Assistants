class Solution {
    public int countBuildings(int[] heights) {
        int count = 0;
        int maxSoFar = 0;
        for (int height : heights) {
            if (height > maxSoFar) {
                count++;
                maxSoFar = height;
            }
        }
        return count;
    }
}