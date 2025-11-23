impl Solution {
    pub fn min_days(blooming: Vec<i32>, m: i32) -> i32 {
        if m > (blooming.len() as i32) {
            return -1;
        }

        let mut left = 0;
        let mut right = *blooming.iter().max().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            if Self::can_make_bouquets(&blooming, m, mid) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }

    fn can_make_bouquets(bloom: &[i32], m: i32, days: i32) -> bool {
        let mut bouquets = 0;
        let mut flowers = 0;

        for &day in bloom {
            if day <= days {
                flowers += 1;
                if flowers == m {
                    return true;
                }
            } else {
                flowers = 0;
            }
        }

        false
    }
}