fn find_solution(customfunction: &CustomFunction, z: i32) -> Vec<Vec<i32>> {
    let mut result: Vec<Vec<i32>> = Vec::new();
    for x in 1..=1000 {
        let mut low = 1;
        let mut high = 1000;
        while low <= high {
            let mid = low + (high - low) / 2;
            let val = customfunction(x, mid);
            if val == z {
                result.push(vec![x, mid]);
                break;
            } else if val < z {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
    }
    result
}