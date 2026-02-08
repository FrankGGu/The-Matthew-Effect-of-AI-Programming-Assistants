use std::collections::HashMap;

impl Solution {
    pub fn least_ops_express_target(x: i32, target: i32) -> i32 {
        let mut memo: HashMap<(i32, i32), i32> = HashMap::new();
        Self::helper(x, target, &mut memo) - 1
    }

    fn helper(x: i32, target: i32, memo: &mut HashMap<(i32, i32), i32>) -> i32 {
        if target == 0 {
            return 0;
        }
        if target == 1 {
            return 1;
        }
        if memo.contains_key(&(x, target)) {
            return *memo.get(&(x, target)).unwrap();
        }

        let mut p = 0;
        let mut num = target;
        while num > 0 {
            num /= x;
            p += 1;
        }

        let num1 = target / i32::pow(x, p - 1);
        let num2 = i32::pow(x, p) - target;

        let op1 = if p == 1 {
            num1 * 2 - 1
        } else {
            Self::helper(x, num1, memo) + (p - 1)
        };

        let op2 = if p == 1 {
            num2 * 2
        } else {
            Self::helper(x, num2, memo) + p
        };

        let result = op1.min(op2);
        memo.insert((x, target), result);
        result
    }
}