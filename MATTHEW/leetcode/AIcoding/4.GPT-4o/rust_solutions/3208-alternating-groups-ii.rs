pub fn alternate_groups(n: i32) -> Vec<i32> {
    let mut result = Vec::new();
    for i in 1..=n {
        if i % 2 == 0 {
            result.push(i);
        }
    }
    for i in 1..=n {
        if i % 2 != 0 {
            result.push(i);
        }
    }
    result
}