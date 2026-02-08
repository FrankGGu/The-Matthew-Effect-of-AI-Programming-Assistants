class Solution {
    public int stoneGameVI(int[] aliceValues, int[] bobValues) {
        int n = aliceValues.length;
        int[][] stones = new int[n][3];
        for (int i = 0; i < n; i++) {
            stones[i][0] = aliceValues[i] + bobValues[i];
            stones[i][1] = aliceValues[i];
            stones[i][2] = bobValues[i];
        }
        Arrays.sort(stones, (a, b) -> b[0] - a[0]);
        int alice = 0, bob = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                alice += stones[i][1];
            } else {
                bob += stones[i][2];
            }
        }
        return Integer.compare(alice, bob);
    }
}