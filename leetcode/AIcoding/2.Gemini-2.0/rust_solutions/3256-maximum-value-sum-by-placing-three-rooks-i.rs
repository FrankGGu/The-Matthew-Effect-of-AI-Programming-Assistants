impl Solution {
    pub fn max_value_sum(nums: Vec<i32>, rooks: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut max_sum = 0;

        for i in 0..n {
            for j in 0..n {
                for k in 0..n {
                    if i == j || i == k || j == k {
                        continue;
                    }

                    let mut current_nums = nums.clone();
                    let mut sum = 0;

                    let r1 = rooks[0][0] as usize;
                    let c1 = rooks[0][1] as usize;
                    let r2 = rooks[1][0] as usize;
                    let c2 = rooks[1][1] as usize;
                    let r3 = rooks[2][0] as usize;
                    let c3 = rooks[2][1] as usize;

                    current_nums[r1] = nums[i];
                    current_nums[r2] = nums[j];
                    current_nums[r3] = nums[k];

                    sum += current_nums[r1];
                    sum += current_nums[r2];
                    sum += current_nums[r3];

                    max_sum = max_sum.max(sum);
                }
            }
        }

        max_sum
    }
}