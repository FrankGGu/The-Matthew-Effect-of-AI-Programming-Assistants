impl Solution {
    pub fn max_number_of_alloys(n: i32, k: i32, budget: i32, composition: Vec<Vec<i32>>, stock: Vec<i32>, cost: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = 2 * 10i32.pow(8);
        let mut answer = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut possible = false;

            for machine in &composition {
                let mut total_cost = 0i64;
                for i in 0..n as usize {
                    let needed = (machine[i] * mid - stock[i]).max(0) as i64;
                    total_cost += needed * cost[i] as i64;
                }
                if total_cost <= budget as i64 {
                    possible = true;
                    break;
                }
            }

            if possible {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer
    }
}