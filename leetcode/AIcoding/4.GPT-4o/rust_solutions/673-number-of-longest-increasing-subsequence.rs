impl Solution {
    pub fn find_number_of_lis(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let mut lengths = vec![1; n];
        let mut counts = vec![1; n];

        for i in 0..n {
            for j in 0..i {
                if nums[i] > nums[j] {
                    if lengths[i] < lengths[j] + 1 {
                        lengths[i] = lengths[j] + 1;
                        counts[i] = counts[j];
                    } else if lengths[i] == lengths[j] + 1 {
                        counts[i] += counts[j];
                    }
                }
            }
        }

        let max_length = *lengths.iter().max().unwrap();
        counts.iter().zip(lengths.iter()).filter(|&(_, &len)| len == max_length).map(|(&count, _)| count).sum()
    }
}