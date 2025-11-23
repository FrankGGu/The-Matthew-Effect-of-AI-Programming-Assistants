struct Solution;

impl Solution {
    pub fn lexical_order(n: i32) -> Vec<i32> {
        let mut result = Vec::with_capacity(n as usize);
        for i in 1..=9 {
            if i <= n {
                Self::dfs(i, n, &mut result);
            }
        }
        result
    }

    fn dfs(current_num: i32, n: i32, result: &mut Vec<i32>) {
        result.push(current_num);

        for i in 0..=9 {
            let next_num = current_num * 10 + i;
            if next_num <= n {
                Self::dfs(next_num, n, result);
            } else {
                break;
            }
        }
    }
}