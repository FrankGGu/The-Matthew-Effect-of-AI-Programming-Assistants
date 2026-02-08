use std::collections::HashMap;

pub fn maximum_xor(nums: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
    let mut max_xor = vec![0; 100001];
    for &num in &nums {
        max_xor[num as usize] = max_xor[num as usize].max(num);
    }

    for i in 1..max_xor.len() {
        max_xor[i] = max_xor[i].max(max_xor[i - 1]);
    }

    queries.iter().map(|&query| max_xor[query as usize]).collect()
}