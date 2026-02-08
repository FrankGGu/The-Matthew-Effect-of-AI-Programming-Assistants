impl Solution {
    fn gcd(a: i64, b: i64) -> i64 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn replace_non_coprime_numbers(nums: Vec<i32>) -> Vec<i32> {
        let mut stack: Vec<i64> = Vec::new();

        for &num_i32 in nums.iter() {
            let mut current_num = num_i32 as i64;

            while let Some(&top) = stack.last() {
                let common_divisor = Self::gcd(top, current_num);
                if common_divisor == 1 {
                    break;
                } else {
                    stack.pop();
                    current_num = (top / common_divisor) * current_num;
                }
            }
            stack.push(current_num);
        }

        stack.into_iter().map(|x| x as i32).collect()
    }
}