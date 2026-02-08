impl Solution {
    pub fn max_strength(nums: Vec<i32>) -> i64 {
        let mut neg_nums: Vec<i32> = Vec::new();
        let mut pos_nums: Vec<i32> = Vec::new();
        let mut zeros = 0;

        for &num in &nums {
            if num < 0 {
                neg_nums.push(num);
            } else if num > 0 {
                pos_nums.push(num);
            } else {
                zeros += 1;
            }
        }

        neg_nums.sort();

        let mut ans: i64 = 1;

        if neg_nums.len() % 2 == 0 {
            for &num in &neg_nums {
                ans *= num as i64;
            }
        } else {
            if neg_nums.len() == 1 && pos_nums.is_empty() && zeros > 0 {
                return 0;
            }
            for i in 0..neg_nums.len() - 1 {
                ans *= neg_nums[i] as i64;
            }
        }

        for &num in &pos_nums {
            ans *= num as i64;
        }

        if ans == 1 && nums.contains(&0) && nums.iter().all(|&x| x <= 0) {
            return 0;
        }

        ans
    }
}