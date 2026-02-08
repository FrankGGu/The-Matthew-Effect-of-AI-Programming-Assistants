pub fn power_of_heroes(a: Vec<i32>, b: Vec<i32>) -> i32 {
    let mut sum = 0;
    for i in 0..a.len() {
        sum += a[i].pow(b[i] as u32);
    }
    sum % 1_000_000_007
}