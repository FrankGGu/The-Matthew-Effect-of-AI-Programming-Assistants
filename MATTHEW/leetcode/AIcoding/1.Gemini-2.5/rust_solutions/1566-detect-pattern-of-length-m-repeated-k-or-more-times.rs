impl Solution {
    pub fn contains_pattern(arr: Vec<i32>, m: i32, k: i32) -> bool {
        let m_usize = m as usize;
        let k_usize = k as usize;

        if m_usize * k_usize > arr.len() {
            return false;
        }

        for i in 0..=(arr.len() - m_usize * k_usize) {
            let mut current_repetitions = 1;

            for j in 1..k_usize {
                let start_of_next_pattern = i + j * m_usize;
                let end_of_next_pattern = start_of_next_pattern + m_usize;

                let pattern_slice = &arr[i..(i + m_usize)];
                let next_pattern_slice = &arr[start_of_next_pattern..end_of_next_pattern];

                if pattern_slice == next_pattern_slice {
                    current_repetitions += 1;
                } else {
                    break;
                }
            }

            if current_repetitions == k_usize {
                return true;
            }
        }

        false
    }
}