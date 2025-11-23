struct Solution;

impl Solution {
    pub fn find_kth_bit(n: i32, k: i32) -> char {
        let mut k = k;
        let mut result = '0';
        let mut flip = false;
        let mut n = n;

        while n > 1 {
            let mid = 1 << (n - 1);
            if k == mid {
                return '1';
            } else if k > mid {
                k = 2 * mid - k;
                flip = !flip;
            }
            n -= 1;
        }

        if flip {
            if result == '0' {
                '1'
            } else {
                '0'
            }
        } else {
            result
        }
    }
}