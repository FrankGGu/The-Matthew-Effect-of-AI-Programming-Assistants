class Solution {
    int[][] memo;
    int[] locations;
    int target;
    int MOD = 1_000_000_007;

    public int countRoutes(int[] locations, int start, int target, int fuel) {
        this.locations = locations;
        this.target = target;
        this.memo = new int[locations.length][fuel + 1];
        for (int i = 0; i < locations.length; i++) {
            for (int j = 0; j < fuel + 1; j++) {
                memo[i][j] = -1;
            }
        }

        return solve(start, fuel);
    }

    private int solve(int currentCity, int currentFuel) {
        if (currentFuel < 0) {
            return 0;
        }
        if (memo[currentCity][currentFuel] != -1) {
            return memo[currentCity][currentFuel];
        }

        int count = 0;
        if (currentCity == target) {
            count = (count + 1) % MOD;
        }

        for (int nextCity = 0; nextCity < locations.length; nextCity++) {
            if (nextCity == currentCity) {
                continue;
            }

            int cost = Math.abs(locations[currentCity] - locations[nextCity]);
            if (currentFuel >= cost) {
                count = (count + solve(nextCity, currentFuel - cost)) % MOD;
            }
        }

        return memo[currentCity][currentFuel] = count;
    }
}