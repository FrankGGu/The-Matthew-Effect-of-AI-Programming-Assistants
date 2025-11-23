pub fn find_nth_value(n: i32, k: i32) -> i32 {
    let mut values = vec![0; (n + 1) as usize];
    values[1] = 1;
    let mut last_index = 1;

    for second in 1..=k {
        let next_index = (second % 2) as usize;
        values[next_index] = last_index + 1;
        last_index = values[next_index];
    }

    values[n as usize]
}