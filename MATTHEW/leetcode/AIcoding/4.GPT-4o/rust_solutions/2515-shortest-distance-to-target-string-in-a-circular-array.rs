pub fn closet_target(words: Vec<String>, target: String, start_index: i32) -> i32 {
    let n = words.len();
    let start_index = start_index as usize;

    let mut min_distance = i32::MAX;

    for i in 0..n {
        if words[i] == target {
            let distance = ((i as i32 - start_index as i32).abs()).min(n as i32 - (i as i32 - start_index as i32).abs());
            min_distance = min_distance.min(distance);
        }
    }

    if min_distance == i32::MAX {
        return -1;
    }
    min_distance
}