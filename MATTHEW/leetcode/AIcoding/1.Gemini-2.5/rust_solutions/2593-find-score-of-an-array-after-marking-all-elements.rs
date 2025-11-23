impl Solution {
    pub fn find_score(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut indexed_nums: Vec<(i32, usize)> = Vec::with_capacity(n);

        for (i, &num) in nums.iter().enumerate() {
            indexed_nums.push((num, i));
        }

        indexed_nums.sort_unstable();

        let mut marked: Vec<bool> = vec![false; n];
        let mut score: i64 = 0;

        for &(num, original_index) in indexed_nums.iter() {
            if !marked[original_index] {
                score += num as i64;
                marked[original_index] = true;

                if original_index > 0 {
                    marked[original_index - 1] = true;
                }
                if original_index < n - 1 {
                    marked[original_index + 1] = true;
                }
            }
        }

        score
    }
}