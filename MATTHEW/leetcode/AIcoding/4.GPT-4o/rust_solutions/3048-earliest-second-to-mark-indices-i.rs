pub fn earliest_full_mark(n: i32, marks: Vec<i32>) -> i32 {
    let mut seen = vec![false; n as usize];
    let mut count = 0;

    for (time, mark) in marks.iter().enumerate() {
        if !seen[*mark as usize] {
            seen[*mark as usize] = true;
            count += 1;
            if count == n {
                return time as i32;
            }
        }
    }
    -1
}