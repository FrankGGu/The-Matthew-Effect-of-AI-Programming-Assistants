impl Solution {
    pub fn construct_array(n: i32, k: i32) -> Vec<i32> {
        let mut res = Vec::with_capacity(n as usize);
        let (mut left, mut right) = (1, n);
        for i in 0..n {
            if k > 1 {
                if i % 2 == 0 {
                    res.push(left);
                    left += 1;
                } else {
                    res.push(right);
                    right -= 1;
                }
                if i < k {
                    continue;
                }
            }
            if i % 2 == 0 {
                res.push(left);
                left += 1;
            } else {
                res.push(right);
                right -= 1;
            }
        }
        res
    }
}