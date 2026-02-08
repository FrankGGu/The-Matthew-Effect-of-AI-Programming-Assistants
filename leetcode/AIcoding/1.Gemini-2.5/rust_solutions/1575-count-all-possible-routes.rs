impl Solution {
    const MOD: i32 = 1_000_000_007;

    fn solve(
        current_city: usize,
        current_fuel: i32,
        locations: &[i32],
        finish: usize,
        memo: &mut Vec<Vec<i32>>,
    ) -> i32 {
        if memo[current_city][current_fuel as usize] != -1 {
            return memo[current_city][current_fuel as usize];
        }

        let mut count = 0;
        // Any time we arrive at the finish city, it counts as one route.
        if current_city == finish {
            count = (count + 1) % Self::MOD;
        }

        let n = locations.len();
        for next_city in 0..n {
            if next_city == current_city {
                continue;
            }

            let fuel_cost = (locations[current_city] - locations[next_city]).abs();

            if current_fuel >= fuel_cost {
                count = (count + Self::solve(
                    next_city,
                    current_fuel - fuel_cost,
                    locations,
                    finish,
                    memo,
                )) % Self::MOD;
            }
        }

        memo[current_city][current_fuel as usize] = count;
        count
    }

    pub fn count_routes(locations: Vec<i32>, start: i32, finish: i32, fuel: i32) -> i32 {
        let n = locations.len();
        // memo[city_idx][fuel_remaining] stores the number of routes
        // from city_idx with fuel_remaining to the finish city.
        // Initialize with -1 to indicate not computed.
        let mut memo = vec![vec![-1; (fuel + 1) as usize]; n];

        Self::solve(start as usize, fuel, &locations, finish as usize, &mut memo)
    }
}