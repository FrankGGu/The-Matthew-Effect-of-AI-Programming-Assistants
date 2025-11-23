use std::collections::HashSet;

pub fn distinct_count_on_board(rolls: Vec<i32>, k: i32) -> i32 {
    let mut seen = HashSet::new();
    for &roll in &rolls {
        seen.insert(roll);
    }
    seen.len() as i32
}