pub fn find_solution(customfunction: &Fn(i32, i32) -> i32, z: i32) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let mut x = 1;
    let mut y = 1000;

    while x <= 1000 && y >= 1 {
        let value = customfunction(x, y);
        if value == z {
            result.push(vec![x, y]);
            x += 1;
        } else if value < z {
            x += 1;
        } else {
            y -= 1;
        }
    }

    result
}