pub fn max_score_indices(nums: Vec<i32>) -> Vec<i32> {
    let n = nums.len();
    let total_ones = nums.iter().sum::<i32>();
    let mut max_score = -1;
    let mut result = Vec::new();

    for i in 0..=n {
        let score = (i as i32) - (total_ones - (n as i32 - i as i32));
        if score > max_score {
            max_score = score;
            result.clear();
            result.push(i as i32);
        } else if score == max_score {
            result.push(i as i32);
        }
    }

    result
}