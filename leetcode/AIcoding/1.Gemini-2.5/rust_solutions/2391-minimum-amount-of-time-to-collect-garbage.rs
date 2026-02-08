impl Solution {
    pub fn garbage_collection(garbage: Vec<String>, travel: Vec<i32>) -> i32 {
        let n = garbage.len();
        let mut total_time = 0;

        let mut last_m_idx: isize = -1;
        let mut last_p_idx: isize = -1;
        let mut last_g_idx: isize = -1;

        for (i, house_garbage) in garbage.iter().enumerate() {
            for c in house_garbage.chars() {
                total_time += 1;
                match c {
                    'M' => last_m_idx = i as isize,
                    'P' => last_p_idx = i as isize,
                    'G' => last_g_idx = i as isize,
                    _ => {}
                }
            }
        }

        let mut travel_prefix_sum = vec![0; n];
        for i in 0..(n - 1) {
            travel_prefix_sum[i + 1] = travel_prefix_sum[i] + travel[i];
        }

        if last_m_idx != -1 {
            total_time += travel_prefix_sum[last_m_idx as usize];
        }
        if last_p_idx != -1 {
            total_time += travel_prefix_sum[last_p_idx as usize];
        }
        if last_g_idx != -1 {
            total_time += travel_prefix_sum[last_g_idx as usize];
        }

        total_time
    }
}