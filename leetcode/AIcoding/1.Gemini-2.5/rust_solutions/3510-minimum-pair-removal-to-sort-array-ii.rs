impl Solution {
    pub fn minimum_pair_removal_to_sort_array_ii(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut tails: Vec<i32> = Vec::new();

        for &num in &nums {
            let idx = tails.partition_point(|&x| x <= num);

            if idx == tails.len() {
                tails.push(num);
            } else {
                tails[idx] = num;
            }
        }

        (nums.len() - tails.len()) as i32
    }
}