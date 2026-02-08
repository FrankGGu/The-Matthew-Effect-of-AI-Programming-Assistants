impl Solution {
    pub fn replace_non_coprimes(nums: Vec<i32>) -> Vec<i32> {
        let mut stack: Vec<i32> = Vec::new();
        for num in nums {
            let mut current = num;
            while let Some(&last) = stack.last() {
                let gcd = Self::gcd(last, current);
                if gcd == 1 {
                    break;
                }
                current = last / gcd * current;
                stack.pop();
            }
            stack.push(current);
        }
        stack
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}