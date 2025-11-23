pub fn large_group_positions(s: String) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let bytes = s.as_bytes();
    let mut start = 0;

    for i in 1..bytes.len() {
        if bytes[i] != bytes[start] {
            if i - start >= 3 {
                result.push(vec![start as i32, (i - 1) as i32]);
            }
            start = i;
        }
    }

    if bytes.len() - start >= 3 {
        result.push(vec![start as i32, (bytes.len() - 1) as i32]);
    }

    result
}