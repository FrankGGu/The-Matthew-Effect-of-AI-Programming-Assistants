pub fn max_array(k: i32) -> Vec<i32> {
    let mut result = Vec::new();
    let mut current_max = 1;

    for i in 0..k {
        result.push(current_max);
        current_max += 1;
    }

    while result.len() < k as usize {
        result.push(current_max);
    }

    result
}