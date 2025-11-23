impl Solution {
    pub fn length_of_lis(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut tails: Vec<i32> = Vec::new();

        for num in nums {
            let i = tails.partition_point(|&x| x < num);

            if i == tails.len() {
                tails.push(num);
            } else {
                tails[i] = num;
            }
        }

        tails.len() as i32
    }
}