pub fn find_duplicate(nums: Vec<i32>) -> Vec<i32> {
    let mut result = vec![0, 0];
    let mut seen = vec![false; nums.len() + 1];

    for &num in &nums {
        if seen[num as usize] {
            result[0] = num;
        }
        seen[num as usize] = true;
    }

    for i in 1..seen.len() {
        if !seen[i] {
            result[1] = i as i32;
            break;
        }
    }

    result
}