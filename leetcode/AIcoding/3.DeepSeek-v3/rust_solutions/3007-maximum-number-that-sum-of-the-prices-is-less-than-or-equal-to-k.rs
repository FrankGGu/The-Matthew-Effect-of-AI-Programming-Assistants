impl Solution {
    pub fn find_maximum_number(k: i64, x: i32) -> i64 {
        let mut left = 1;
        let mut right = 1e18 as i64;
        let mut answer = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let total = Self::calculate_sum(mid, x);
            if total <= k {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        answer
    }

    fn calculate_sum(num: i64, x: i32) -> i64 {
        let mut sum = 0;
        let x = x as u32;
        for i in 1..=60 {
            if i % x as u32 == 0 {
                let bit = 1 << (i - 1);
                let full_cycles = num / (1 << i);
                let remainder = num % (1 << i);
                sum += full_cycles * (1 << (i - 1));
                sum += if remainder >= bit { remainder - bit + 1 } else { 0 };
            }
        }
        sum
    }
}