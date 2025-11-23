impl Solution {
    pub fn find_score(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut marked = vec![false; n];
        let mut score = 0i64;
        let mut indices: Vec<usize> = (0..n).collect();
        indices.sort_by(|&i, &j| {
            if nums[i] == nums[j] {
                i.cmp(&j)
            } else {
                nums[i].cmp(&nums[j])
            }
        });

        for &i in &indices {
            if !marked[i] {
                score += nums[i] as i64;
                marked[i] = true;
                if i > 0 {
                    marked[i - 1] = true;
                }
                if i < n - 1 {
                    marked[i + 1] = true;
                }
            }
        }

        score
    }
}