pub fn can_enter(people: Vec<i32>, limit: i32) -> bool {
    let mut total_weight = 0;
    for weight in people {
        total_weight += weight;
        if total_weight > limit {
            return false;
        }
    }
    true
}