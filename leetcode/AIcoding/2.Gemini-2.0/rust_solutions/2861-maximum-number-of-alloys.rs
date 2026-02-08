impl Solution {
    pub fn max_number_of_alloys(n: i32, k: i32, budget: i32, composition: Vec<Vec<i32>>, stock: Vec<i32>, cost: Vec<i32>) -> i32 {
        let mut left = 0;
        let mut right = 100000000;
        let mut ans = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut possible = false;

            for i in 0..k as usize {
                let mut total_cost = 0;
                for j in 0..n as usize {
                    let need = (composition[i][j] * mid as i64) as i64;
                    if need > stock[j] as i64 {
                        total_cost += ((need - stock[j] as i64) * cost[j] as i64) as i64;
                    }
                }
                if total_cost <= budget as i64 {
                    possible = true;
                    break;
                }
            }

            if possible {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        ans
    }
}