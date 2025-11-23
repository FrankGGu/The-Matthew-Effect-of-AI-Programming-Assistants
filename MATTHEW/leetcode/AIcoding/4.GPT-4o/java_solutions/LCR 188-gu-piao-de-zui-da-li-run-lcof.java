class Solution {
    public int minCost(int[] chips) {
        int even = 0, odd = 0;
        for (int chip : chips) {
            if (chip % 2 == 0) {
                even++;
            } else {
                odd++;
            }
        }
        return Math.min(even, odd);
    }
}