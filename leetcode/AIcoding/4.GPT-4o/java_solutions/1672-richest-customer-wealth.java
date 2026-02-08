class Solution {
    public int maximumWealth(int[][] accounts) {
        int maxWealth = 0;
        for (int[] account : accounts) {
            int currentWealth = 0;
            for (int wealth : account) {
                currentWealth += wealth;
            }
            maxWealth = Math.max(maxWealth, currentWealth);
        }
        return maxWealth;
    }
}