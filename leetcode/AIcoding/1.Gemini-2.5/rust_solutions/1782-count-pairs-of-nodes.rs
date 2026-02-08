use std::collections::HashMap;

impl Solution {
    pub fn count_pairs(n: i32, edges: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let n = n as usize;
        let max_deg_sum = 2 * (n - 1);

        let mut degrees = vec![0; n + 1]; // 1-indexed degrees
        let mut edge_counts: HashMap<(usize, usize), i32> = HashMap::new();

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            degrees[u] += 1;
            degrees[v] += 1;

            let (u_norm, v_norm) = if u < v { (u, v) } else { (v, u) };
            *edge_counts.entry((u_norm, v_norm)).or_insert(0) += 1;
        }

        let mut degree_freq = vec![0; n]; // Max degree is n-1
        for i in 1..=n {
            degree_freq[degrees[i] as usize] += 1;
        }

        let mut num_pairs_sum_eq_s = vec![0; max_deg_sum + 1];
        for d1 in 0..n {
            if degree_freq[d1] == 0 {
                continue;
            }
            for d2 in d1..n {
                if degree_freq[d2] == 0 {
                    continue;
                }
                if d1 + d2 > max_deg_sum {
                    continue;
                }
                if d1 == d2 {
                    num_pairs_sum_eq_s[d1 + d2] += degree_freq[d1] * (degree_freq[d1] - 1) / 2;
                } else {
                    num_pairs_sum_eq_s[d1 + d2] += degree_freq[d1] * degree_freq[d2];
                }
            }
        }

        let mut num_pairs_sum_gt_s = vec![0; max_deg_sum + 2];
        for s in (0..=max_deg_sum).rev() {
            num_pairs_sum_gt_s[s] = num_pairs_sum_gt_s[s + 1] + num_pairs_sum_eq_s[s];
        }

        let mut diff_array = vec![0; max_deg_sum + 2];

        for (&(u, v), &count) in &edge_counts {
            let sum_degrees = degrees[u] + degrees[v];
            let start_q = (sum_degrees - count).max(0);
            let end_q = sum_degrees - 1;

            if start_q <= end_q {
                diff_array[start_q as usize] -= 1;
                diff_array[(end_q + 1) as usize] += 1;
            }
        }

        let mut final_answers = vec![0; max_deg_sum + 1];
        let mut current_adjustment = 0;
        for q_val in 0..=max_deg_sum {
            current_adjustment += diff_array[q_val];
            final_answers[q_val] = num_pairs_sum_gt_s[q_val] + current_adjustment;
        }

        let mut results = Vec::with_capacity(queries.len());
        for q in queries {
            results.push(final_answers[q as usize]);
        }

        results
    }
}