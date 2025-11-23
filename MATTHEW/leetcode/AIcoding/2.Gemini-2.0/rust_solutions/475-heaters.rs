impl Solution {
    pub fn find_radius(houses: Vec<i32>, heaters: Vec<i32>) -> i32 {
        let mut heaters = heaters;
        heaters.sort();
        let mut ans = 0;
        for house in houses {
            let mut left = 0;
            let mut right = heaters.len() - 1;
            let mut min_dist = i32::MAX;
            while left <= right {
                let mid = left + (right - left) / 2;
                let dist = (heaters[mid] - house).abs();
                min_dist = min_dist.min(dist);
                if heaters[mid] < house {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            ans = ans.max(min_dist);
        }
        ans
    }
}