struct Solution;

impl Solution {
    pub fn numberOfAlternatingGroups2(
        colors: Vec<i32>,
        k: i32,
    ) -> i32 {
        let n = colors.len();
        let k = k as usize;
        let mut count = 0;
        for i in 0..n {
            let mut is_valid = true;
            for j in 1..k {
                if colors[(i + j) % n] == colors[(i + j - 1) % n] {
                    is_valid = false;
                    break;
                }
            }
            if is_valid {
                count += 1;
            }
        }
        count
    }
}