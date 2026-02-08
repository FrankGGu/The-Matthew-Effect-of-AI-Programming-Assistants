impl Solution {
    pub fn number_of_unique_xor_triplets(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            for j in (i + 1)..n {
                for k in (j + 1)..n {
                    if (nums[i] ^ nums[j] ^ nums[k]) == 0 {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}