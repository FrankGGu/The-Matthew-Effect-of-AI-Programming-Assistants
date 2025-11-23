impl Solution {
    pub fn capture_forts(forts: Vec<i32>) -> i32 {
        let mut max_captured = 0;
        let mut last = -1;

        for i in 0..forts.len() {
            if forts[i] != 0 {
                if last != -1 && forts[i] != forts[last as usize] {
                    let mut captured = 0;
                    for j in (last + 1) as usize..i {
                        if forts[j] == 0 {
                            captured += 1;
                        } else {
                            captured = 0;
                            break;
                        }
                    }
                    max_captured = max_captured.max(captured);
                }
                last = i as i32;
            }
        }

        max_captured
    }
}