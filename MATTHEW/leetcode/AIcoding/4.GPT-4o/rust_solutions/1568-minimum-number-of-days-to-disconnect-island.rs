pub fn min_days(bloom_day: Vec<i32>, m: i32, k: i32) -> i32 {
    fn can_make(bloom_day: &Vec<i32>, m: i32, k: i32, day: i32) -> bool {
        let mut count = 0;
        let mut flowers = 0;
        for &bloom in bloom_day {
            if bloom <= day {
                flowers += 1;
                if flowers == k {
                    count += 1;
                    flowers = 0;
                }
            } else {
                flowers = 0;
            }
        }
        count >= m
    }

    let max_bloom = *bloom_day.iter().max().unwrap();
    let min_bloom = *bloom_day.iter().min().unwrap();

    let (mut left, mut right) = (min_bloom, max_bloom);
    while left < right {
        let mid = left + (right - left) / 2;
        if can_make(&bloom_day, m, k, mid) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    if can_make(&bloom_day, m, k, left) { left } else { -1 }
}