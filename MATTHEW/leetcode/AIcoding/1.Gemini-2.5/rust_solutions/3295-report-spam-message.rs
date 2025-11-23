use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn report_spam_message(id_list: Vec<String>, report: Vec<String>, k: i32) -> Vec<i32> {
        let n = id_list.len();
        let mut id_to_idx: HashMap<String, usize> = HashMap::new();
        for (i, id) in id_list.iter().enumerate() {
            id_to_idx.insert(id.clone(), i);
        }

        // reported_by_who[reported_idx] = set of reporter_idx's who reported them.
        let mut reported_by_who: Vec<HashSet<usize>> = vec![HashSet::new(); n];
        // user_reported_others[reporter_idx] = set of reported_idx's they reported.
        let mut user_reported_others: Vec<HashSet<usize>> = vec![HashSet::new(); n];

        for r_str in report {
            let parts: Vec<&str> = r_str.split_whitespace().collect();
            let reporter_id = parts[0];
            let reported_id = parts[1];

            let reporter_idx = *id_to_idx.get(reporter_id).unwrap();
            let reported_idx = *id_to_idx.get(reported_id).unwrap();

            // Store distinct reporters for each reported user
            reported_by_who[reported_idx].insert(reporter_idx);

            // Store distinct users reported by each reporter
            user_reported_others[reporter_idx].insert(reported_idx);
        }

        // Identify users who are "spam-reported" (reported by k or more distinct users)
        let mut is_spam_user: Vec<bool> = vec![false; n];
        for i in 0..n {
            if reported_by_who[i].len() >= k as usize {
                is_spam_user[i] = true;
            }
        }

        // Calculate mail counts for each user
        let mut mail_counts: Vec<i32> = vec![0; n];
        for i in 0..n { // i is reporter_idx
            for &reported_idx in &user_reported_others[i] {
                if is_spam_user[reported_idx] {
                    mail_counts[i] += 1;
                }
            }
        }

        mail_counts
    }
}