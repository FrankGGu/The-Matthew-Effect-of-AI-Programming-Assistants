impl Solution {
    pub fn max_value_after_reverse(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let mut max_val = 0;
        let mut min1 = nums[0];
        let mut max1 = nums[0];
        let mut min2 = nums[1];
        let mut max2 = nums[1];

        for i in 1..n {
            max_val = std::cmp::max(max_val, (nums[i - 1] - nums[i]).abs());
            if i >= 2 {
                let a = nums[i - 2];
                let b = nums[i - 1];
                let c = nums[i];
                let d = nums[i + 1];
                let val1 = (a - c).abs() + (b - d).abs();
                let val2 = (a - d).abs() + (c - b).abs();
                let val3 = (b - c).abs() + (a - d).abs();
                let val4 = (b - d).abs() + (a - c).abs();
                max_val = std::cmp::max(max_val, val1, val2, val3, val4);
            }
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val = (a - b).abs();
            max_val = std::cmp::max(max_val, val);
        }

        for i in 1..n {
            let a = nums[i - 1];
            let b = nums[i];
            let val......
        }

        max_val
    }
}