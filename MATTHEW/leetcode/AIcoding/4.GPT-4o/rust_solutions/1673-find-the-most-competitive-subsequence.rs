pub fn most_competitive(nums: Vec<i32>, k: i32) -> Vec<i32> {
    let n = nums.len();
    let k = k as usize;
    let mut stack = Vec::new();
    let to_pop = n - k;

    for (i, &num) in nums.iter().enumerate() {
        while !stack.is_empty() && to_pop > 0 && *stack.last().unwrap() > num {
            stack.pop();
            if to_pop > 0 {
                to_pop -= 1;
            }
        }
        stack.push(num);
    }

    stack.truncate(k);
    stack
}