impl Solution {
    pub fn minimized_max(p: Vec<i32>, n: i32) -> i32 {
        let (mut left, mut right) = (1, *p.iter().max().unwrap());

        while left < right {
            let mid = (left + right) / 2;
            let total = p.iter().map(|&x| (x + mid - 1) / mid).sum::<i32>();

            if total > n {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}