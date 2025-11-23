pub fn max_distance(arrays: Vec<Vec<i32>>) -> i32 {
    let mut min_val = arrays[0][0];
    let mut max_val = arrays[0][0];
    let mut max_distance = 0;

    for array in arrays.iter().skip(1) {
        max_distance = max_distance.max((array.last().unwrap() - min_val).abs());
        max_distance = max_distance.max((max_val - array.first().unwrap()).abs());
        min_val = min_val.min(array.first().unwrap());
        max_val = max_val.max(array.last().unwrap());
    }

    max_distance
}