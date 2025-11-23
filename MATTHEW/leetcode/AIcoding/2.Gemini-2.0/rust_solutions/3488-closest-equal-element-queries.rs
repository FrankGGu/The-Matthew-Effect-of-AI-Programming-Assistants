impl Solution {
    pub fn closest_equal_elements(arr: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut positions: std::collections::HashMap<i32, Vec<i32>> =
            std::collections::HashMap::new();
        for (i, &val) in arr.iter().enumerate() {
            positions.entry(val).or_insert(Vec::new()).push(i as i32);
        }

        let mut result: Vec<i32> = Vec::new();
        for query in queries {
            let left = query[0];
            let right = query[1];
            let mut min_dist = -1;

            for (&val, pos_vec) in &positions {
                let mut l_idx = -1;
                let mut r_idx = -1;

                let mut left_bound = 0;
                let mut right_bound = pos_vec.len() as i32 - 1;

                while left_bound <= right_bound {
                    let mid = left_bound + (right_bound - left_bound) / 2;
                    if pos_vec[mid as usize] >= left {
                        r_idx = pos_vec[mid as usize];
                        right_bound = mid - 1;
                    } else {
                        left_bound = mid + 1;
                    }
                }

                left_bound = 0;
                right_bound = pos_vec.len() as i32 - 1;

                while left_bound <= right_bound {
                    let mid = left_bound + (right_bound - left_bound) / 2;
                    if pos_vec[mid as usize] <= right {
                        l_idx = pos_vec[mid as usize];
                        left_bound = mid + 1;
                    } else {
                        right_bound = mid - 1;
                    }
                }

                if l_idx == -1 || r_idx == -1 {
                    continue;
                }

                let mut best_dist = i32::MAX;
                for &i in pos_vec {
                    if i >= left && i <= right {
                        let mut found = false;
                        for &j in pos_vec {
                            if j >= left && j <= right && i != j {
                                best_dist = best_dist.min((i - j).abs());
                                found = true;
                            }
                        }
                        if found {
                            break;
                        }
                    }
                }

                if best_dist != i32::MAX {
                    if min_dist == -1 {
                        min_dist = best_dist;
                    } else {
                        min_dist = min_dist.min(best_dist);
                    }
                }
            }
            result.push(min_dist);
        }
        result
    }
}