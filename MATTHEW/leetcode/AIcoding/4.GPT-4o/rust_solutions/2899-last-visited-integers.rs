pub fn find_last_visited(nums: Vec<i32>, k: i32) -> Vec<i32> {
    let mut visited = std::collections::HashSet::new();
    let mut result = Vec::new();

    for &num in nums.iter().rev() {
        if visited.len() >= k as usize {
            break;
        }
        if visited.insert(num) {
            result.push(num);
        }
    }

    result.reverse();
    result
}