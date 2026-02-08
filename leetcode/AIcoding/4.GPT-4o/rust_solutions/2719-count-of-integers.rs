pub fn count_integers(n: i32, k: i32) -> i32 {
    let mut count = 0;
    for i in 1..=n {
        if i.to_string().matches(k.to_string().as_str()).count() == 0 {
            count += 1;
        }
    }
    count
}