impl Solution {
    pub fn min_cost_to_brew_k_potions(success: Vec<i32>, potion: Vec<i32>, k: i32) -> i64 {
        let n = success.len();
        let mut items: Vec<(i32, i32)> = success.into_iter().zip(potion.into_iter()).collect();
        items.sort_by_key(|&(s, p)| s);

        let mut l: i64 = 0;
        let mut r: i64 = 1_000_000_000_000_000;

        while l < r {
            let mid = l + (r - l) / 2;
            let mut count: i32 = 0;
            for &(s, p) in &items {
                count += (mid / (p as i64) >= s as i64) as i32;
            }

            if count >= k {
                r = mid;
            } else {
                l = mid + 1;
            }
        }

        l
    }
}