var countRoutes = function(locations, start, finish, fuel) {
    const n = locations.length;
    const MOD = 10 ** 9 + 7;

    const memo = Array(n).fill(0).map(() => Array(fuel + 1).fill(-1));

    function dfs(currentCity, currentFuel) {
        if (memo[currentCity][currentFuel] !== -1) {
            return memo[currentCity][currentFuel];
        }

        let count = currentCity === finish ? 1 : 0;

        for (let nextCity = 0; nextCity < n; nextCity++) {
            if (nextCity === currentCity) {
                continue;
            }

            const fuelNeeded = Math.abs(locations[currentCity] - locations[nextCity]);

            if (currentFuel >= fuelNeeded) {
                count = (count + dfs(nextCity, currentFuel - fuelNeeded)) % MOD;
            }
        }

        memo[currentCity][currentFuel] = count;
        return count;
    }

    return dfs(start, fuel);
};