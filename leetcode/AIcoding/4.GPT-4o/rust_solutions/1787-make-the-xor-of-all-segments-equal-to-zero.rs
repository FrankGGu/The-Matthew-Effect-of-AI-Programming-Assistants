pub fn xor_queries(arr: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let n = arr.len();
    let mut prefix_xor = vec![0; n + 1];

    for i in 0..n {
        prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
    }

    queries
        .iter()
        .map(|query| prefix_xor[query[1] as usize + 1] ^ prefix_xor[query[0] as usize])
        .collect()
}