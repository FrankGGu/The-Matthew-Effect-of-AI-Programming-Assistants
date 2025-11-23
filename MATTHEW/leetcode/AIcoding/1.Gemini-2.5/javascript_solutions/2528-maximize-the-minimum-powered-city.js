var maximizeTheMinimumPoweredCity = function(cities, r, k) {
    const n = cities.length;
    let low = 0;
    let high = 0;

    for (let i = 0; i < n; i++) {
        high = Math.max(high, cities[i]);
    }
    high += k;

    let ans = 0;

    const check = (target_min_power) => {
        const added_power_from_stations = new Array(n + 1).fill(0);
        let stations_used = 0;
        let current_station_effect_sum = 0;

        for (let i = 0; i < n; i++) {
            current_station_effect_sum += added_power_from_stations[i];
            let total_power_at_i = cities[i] + current_station_effect_sum;

            if (total_power_at_i < target_min_power) {
                const needed = target_min_power - total_power_at_i;
                stations_used += needed;

                if (stations_used > k) {
                    return false;
                }

                current_station_effect_sum += needed;

                // A power station built to cover city `i` optimally should be placed at `i + r`.
                // This station will provide power to cities in the range `[ (i+r) - r, (i+r) + r ]`,
                // which simplifies to `[i, i + 2*r]`.
                // The effect of `needed` power starts at `i` and ends at `i + 2*r`.
                // So, we add `needed` to `current_station_effect_sum` for cities from `i` to `i + 2*r`.
                // The effect should stop at `i + 2*r + 1`.
                if (i + 2 * r + 1 < n) {
                    added_power_from_stations[i + 2 * r + 1] -= needed;
                }
            }
        }
        return true;
    };

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};