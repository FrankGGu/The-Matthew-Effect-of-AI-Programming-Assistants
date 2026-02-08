impl Solution {
    pub fn file_combination(target: i32) -> Vec<Vec<i32>> {
        let mut res = Vec::new();
        let (mut left, mut right) = (1, 2);
        let mut sum = left + right;
        while left < right {
            if sum == target {
                res.push((left..=right).collect());
                sum -= left;
                left += 1;
            } else if sum < target {
                right += 1;
                sum += right;
            } else {
                sum -= left;
                left += 1;
            }
        }
        res
    }
}