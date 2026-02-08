use std::cmp::min;

impl Solution {
    pub fn find_cheapest_price(n: i32, flights: Vec<Vec<i32>>, src: i32, dst: i32, k: i32) -> i32 {
        let n = n as usize;
        let src = src as usize;
        let dst = dst as usize;
        let k = k as usize;

        // dp[i][j] will store the minimum cost to reach city 'j' using at most 'i' flights.
        // 'i' ranges from 0 to k+1 (inclusive).
        // So, the size of the first dimension is k + 2.
        let mut dp: Vec<Vec<i32>> = vec![vec![i32::MAX; n]; k + 2];

        // Base case: To reach 'src' with 0 flights costs 0.
        dp[0][src] = 0;

        // Populate dp table for 1 to k+1 flights.
        // 'num_flights' here represents the maximum number of flights allowed.
        for num_flights in 1..=k + 1 {
            // Initialize current row with values from the previous row.
            // This means we can reach cities with 'num_flights' at the same cost
            // as with 'num_flights - 1' if we simply don't take an additional flight.
            for city_idx in 0..n {
                dp[num_flights][city_idx] = dp[num_flights - 1][city_idx];
            }

            // Iterate through all flights to update costs for 'num_flights'.
            for flight in &flights {
                let from = flight[0] as usize;
                let to = flight[1] as usize;
                let price = flight[2];

                // If 'from' city was reachable with 'num_flights - 1' flights,
                // then 'to' city can be reached with 'num_flights' flights.
                if dp[num_flights - 1][from] != i32::MAX {
                    dp[num_flights][to] = min(dp[num_flights][to], dp[num_flights - 1][from] + price);
                }
            }
        }

        // The minimum cost to reach 'dst' is the minimum value across all
        // allowed number of flights (0 to k+1).
        let mut min_price = i32::MAX;
        for num_flights in 0..=k + 1 {
            min_price = min(min_price, dp[num_flights][dst]);
        }

        // If 'min_price' is still MAX, it means 'dst' is unreachable.
        if min_price == i32::MAX {
            -1
        } else {
            min_price
        }
    }
}