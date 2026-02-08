impl Solution {
    pub fn security_check(capacities: Vec<i32>, k: i32) -> i32 {
        let mut l = 1;
        let mut r = *capacities.iter().max().unwrap();
        let mut ans = r;

        while l <= r {
            let mid = l + (r - l) / 2;
            let mut cnt = 1;
            let mut cur = 0;
            for &c in &capacities {
                if cur + c > mid {
                    cnt += 1;
                    cur = 0;
                }
                cur += c;
            }

            if cnt <= k {
                ans = mid;
                r = mid - 1;
            } else {
                l = mid + 1;
            }
        }

        ans
    }
}