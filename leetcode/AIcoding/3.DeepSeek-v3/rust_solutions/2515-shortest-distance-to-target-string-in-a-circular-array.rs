impl Solution {
    pub fn closet_target(words: Vec<String>, target: String, start_index: i32) -> i32 {
        let n = words.len() as i32;
        let mut min_distance = i32::MAX;

        for i in 0..n {
            if words[i as usize] == target {
                let distance = (i - start_index).abs().min(n - (i - start_index).abs());
                if distance < min_distance {
                    min_distance = distance;
                }
            }
        }

        if min_distance == i32::MAX {
            -1
        } else {
            min_distance
        }
    }
}