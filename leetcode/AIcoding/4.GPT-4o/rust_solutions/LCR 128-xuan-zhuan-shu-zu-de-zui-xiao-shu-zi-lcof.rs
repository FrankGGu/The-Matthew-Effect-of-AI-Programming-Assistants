pub fn check_inventory(inventory: Vec<Vec<i32>>) -> i32 {
    let mut total = 0;
    for item in inventory {
        total += item[0] * item[1];
    }
    total
}