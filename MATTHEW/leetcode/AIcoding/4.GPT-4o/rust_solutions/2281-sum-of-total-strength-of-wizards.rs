pub fn total_strength(strength: Vec<i32>) -> i32 {
    let mod_val = 1_000_000_007;
    let n = strength.len();
    let mut left = vec![0; n];
    let mut right = vec![0; n];
    let mut stack = Vec::new();

    for i in 0..n {
        while let Some(&j) = stack.last() {
            if strength[j] < strength[i] {
                stack.pop();
            } else {
                break;
            }
        }
        left[i] = if stack.is_empty() { -1 } else { stack.last().copied().unwrap() };
        stack.push(i);
    }

    stack.clear();

    for i in (0..n).rev() {
        while let Some(&j) = stack.last() {
            if strength[j] <= strength[i] {
                stack.pop();
            } else {
                break;
            }
        }
        right[i] = if stack.is_empty() { n as i32 } else { stack.last().copied().unwrap() as i32 };
        stack.push(i);
    }

    let mut prefix_sum = vec![0; n + 1];
    for i in 0..n {
        prefix_sum[i + 1] = (prefix_sum[i] + strength[i]) % mod_val;
    }

    let mut total = 0;
    for i in 0..n {
        let l = left[i] + 1;
        let r = right[i];
        let sum = (prefix_sum[r as usize] - prefix_sum[l as usize] + mod_val) % mod_val;
        total = (total + sum * strength[i]) % mod_val;
    }

    total
}