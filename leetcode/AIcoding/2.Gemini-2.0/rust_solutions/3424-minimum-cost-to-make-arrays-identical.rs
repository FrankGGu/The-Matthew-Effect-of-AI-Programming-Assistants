impl Solution {
    pub fn min_cost(nums1: Vec<i32>, nums2: Vec<i32>, cost: Vec<i32>) -> i64 {
        let n = nums1.len();
        let mut diff = Vec::new();
        for i in 0..n {
            if nums1[i] != nums2[i] {
                diff.push((nums1[i] - nums2[i], cost[i]));
            }
        }

        let mut unique_values = std::collections::HashSet::new();
        for &(d, _) in &diff {
            unique_values.insert(d);
        }

        let unique_values_vec: Vec<i32> = unique_values.into_iter().collect();
        let m = unique_values_vec.len();

        if m == 0 {
            return 0;
        }

        let mut adj: std::collections::HashMap<i32, Vec<(i32, i32)>> = std::collections::HashMap::new();

        for i in 0..m {
            for j in 0..m {
                if i != j {
                    let u = unique_values_vec[i];
                    let v = unique_values_vec[j];
                    let mut weight = 0;
                    for &(d, c) in &diff {
                        if d == u {
                            weight += c as i64;
                        }
                    }
                    adj.entry(u).or_insert(Vec::new()).push((v, weight as i32));
                }
            }
        }

        let mut min_cost = i64::MAX;
        for start_node in &unique_values_vec {
            let mut visited = std::collections::HashSet::new();
            let mut current_cost = 0;
            let mut current_node = *start_node;

            let mut all_zero = true;
            for &(d, _) in &diff {
                if d != 0 {
                    all_zero = false;
                    break;
                }
            }

            if all_zero {
                return 0;
            }

            let mut diff_copy = diff.clone();

            loop {
                visited.insert(current_node);
                let mut found_next = false;
                let mut min_neighbor = None;
                let mut min_neighbor_cost = i64::MAX;

                if let Some(neighbors) = adj.get(&current_node) {
                    for &(neighbor, cost) in neighbors {
                        if !visited.contains(&neighbor) {
                            if (cost as i64) < min_neighbor_cost {
                                min_neighbor = Some(neighbor);
                                min_neighbor_cost = cost as i64;
                                found_next = true;
                            }
                        }
                    }
                }

                if !found_next {
                    break;
                }

                let next_node = min_neighbor.unwrap();

                current_cost += min_neighbor_cost;

                for i in 0..diff_copy.len() {
                    if diff_copy[i].0 == current_node {
                        diff_copy[i].0 = next_node;
                    }
                }

                current_node = next_node;
            }

            let mut all_same = true;
            if diff_copy.len() > 0 {
                let first_val = diff_copy[0].0;
                for &(d, _) in &diff_copy {
                    if d != first_val {
                        all_same = false;
                        break;
                    }
                }
            }

            if all_same && current_cost < min_cost {
                min_cost = current_cost;
            }
        }

        let mut sum_pos = 0i64;
        let mut sum_neg = 0i64;
        for &(d, c) in &diff {
            if d > 0 {
                sum_pos += c as i64;
            } else {
                sum_neg += c as i64;
            }
        }

        if sum_pos == 0 || sum_neg == 0 {
            return 0;
        }

        let mut ans = i64::MAX;

        let mut map: std::collections::HashMap<i32, i64> = std::collections::HashMap::new();

        for i in 0..n {
            if nums1[i] != nums2[i] {
                let diff_val = nums1[i] - nums2[i];
                *map.entry(diff_val).or_insert(0) += cost[i] as i64;
            }
        }

        let mut keys: Vec<i32> = map.keys().cloned().collect();
        keys.sort();

        let mut prefix_sum: std::collections::HashMap<i32, i64> = std::collections::HashMap::new();
        let mut current_sum = 0i64;

        for key in &keys {
            current_sum += *map.get(key).unwrap();
            prefix_sum.insert(*key, current_sum);
        }

        for key in &keys {
            let cost_to_make_all_less = if prefix_sum.contains_key(key) {
                prefix_sum.get(key).unwrap() - map.get(key).unwrap()
            } else {
                0
            };

            let cost_to_make_all_greater = current_sum - prefix_sum.get(key).unwrap();

            ans = ans.min(cost_to_make_all_less.abs().min(cost_to_make_all_greater.abs()));
        }

        ans

    }
}