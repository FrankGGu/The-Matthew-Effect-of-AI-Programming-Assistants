struct Solution;

impl Solution {
    pub fn beautiful_array(n: i32) -> Vec<i32> {
        if n == 1 {
            return vec![1];
        }

        let mut ans = Vec::with_capacity(n as usize);

        let left_size = (n + 1) / 2;
        let left_half = Self::beautiful_array(left_size);
        for &x in left_half.iter() {
            ans.push(2 * x - 1);
        }

        let right_size = n / 2;
        let right_half = Self::beautiful_array(right_size);
        for &x in right_half.iter() {
            ans.push(2 * x);
        }

        ans
    }
}