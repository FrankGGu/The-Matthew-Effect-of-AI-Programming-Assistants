struct Solution;

impl Solution {
    pub fn three_equal_parts(arr: Vec<i32>) -> Vec<i32> {
        let mut ones = vec![];
        for (i, &val) in arr.iter().enumerate() {
            if val == 1 {
                ones.push(i);
            }
        }

        let n = ones.len();
        if n % 3 != 0 {
            return vec![-1, -1];
        }

        if n == 0 {
            return vec![0, 2];
        }

        let m = n / 3;
        let first = ones[0];
        let second = ones[m];
        let third = ones[2 * m];

        let len = arr.len() - third;
        if first + len > second || second + len > third {
            return vec![-1, -1];
        }

        vec![first + len as i32, second + len as i32]
    }
}