pub fn min_deletion_size(strs: Vec<String>) -> i32 {
    let mut count = 0;
    let n = strs.len();
    let m = strs[0].len();

    for col in 0..m {
        for row in 1..n {
            if strs[row].as_bytes()[col] < strs[row - 1].as_bytes()[col] {
                count += 1;
                break;
            }
        }
    }

    count
}