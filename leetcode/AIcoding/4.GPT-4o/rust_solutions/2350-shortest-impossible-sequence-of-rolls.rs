pub fn shortest_impossible_sequence(rolls: Vec<i32>, k: i32) -> i32 {
    let mut seen = std::collections::HashSet::new();
    let mut length = 0;

    for roll in rolls {
        seen.insert(roll);
        while seen.len() == length + 1 {
            length += 1;
        }
    }

    length + 1
}