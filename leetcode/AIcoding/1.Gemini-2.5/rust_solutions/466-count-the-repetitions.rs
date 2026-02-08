struct Solution;

impl Solution {
    pub fn get_max_repetitions(s1: String, n1: i32, s2: String, n2: i32) -> i32 {
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        let s2_len = s2_chars.len();
        if s2_len == 0 {
            return 0;
        }

        let mut s2_ptr: usize = 0;
        let mut s2_reps_completed: i64 = 0;

        let mut history: Vec<Option<(i32, i64)>> = vec![None; s2_len];

        let mut s1_reps_consumed: i32 = 0;

        while s1_reps_consumed < n1 {
            let current_s2_ptr_before_s1 = s2_ptr;

            if history[current_s2_ptr_before_s1].is_some() {
                let (prev_s1_reps, prev_s2_reps) = history[current_s2_ptr_before_s1].unwrap();

                let s1_reps_in_cycle = s1_reps_consumed - prev_s1_reps;
                let s2_reps_in_cycle = s2_reps_completed - prev_s2_reps;

                let remaining_s1_reps = n1 - s1_reps_consumed;
                let num_cycles = remaining_s1_reps / s1_reps_in_cycle;

                s2_reps_completed += num_cycles as i64 * s2_reps_in_cycle;
                s1_reps_consumed += num_cycles * s1_reps_in_cycle;
            } else {
                history[current_s2_ptr_before_s1] = Some((s1_reps_consumed, s2_reps_completed));
            }

            for &c1 in s1_chars.iter() {
                if c1 == s2_chars[s2_ptr] {
                    s2_ptr += 1;
                    if s2_ptr == s2_len {
                        s2_ptr = 0;
                        s2_reps_completed += 1;
                    }
                }
            }

            s1_reps_consumed += 1;
        }

        (s2_reps_completed / n2 as i64) as i32
    }
}