pub fn max_consecutive_floors(floors: Vec<i32>, special: Vec<i32>) -> i32 {
    let mut special_set: std::collections::HashSet<i32> = special.into_iter().collect();
    let mut max_consecutive = 0;
    let mut current_consecutive = 0;

    for floor in floors {
        if !special_set.contains(&floor) {
            current_consecutive += 1;
            max_consecutive = max_consecutive.max(current_consecutive);
        } else {
            current_consecutive = 0;
        }
    }

    max_consecutive
}