pub fn maximum_operations(nums: Vec<i32>, start: i32, goal: i32) -> i32 {
    let mut count = 0;
    let mut current = start;

    while current != goal && count < nums.len() {
        let mut max_diff = 0;
        for &num in &nums {
            let diff = (current - num).abs();
            if diff > max_diff {
                max_diff = diff;
            }
        }
        if max_diff == 0 {
            break;
        }
        current = if current < goal { current + max_diff } else { current - max_diff };
        count += 1;
    }

    if current == goal {
        count
    } else {
        -1
    }
}