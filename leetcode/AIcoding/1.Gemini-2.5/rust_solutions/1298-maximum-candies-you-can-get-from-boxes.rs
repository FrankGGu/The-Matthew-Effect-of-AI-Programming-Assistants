use std::collections::VecDeque;

impl Solution {
    pub fn max_candies(
        status: Vec<i32>,
        candies: Vec<i32>,
        keys: Vec<Vec<i32>>,
        contained_boxes: Vec<Vec<i32>>,
        initial_boxes: Vec<i32>,
    ) -> i32 {
        let n = status.len();

        let mut current_status: Vec<bool> = status.into_iter().map(|s| s == 1).collect();
        let mut has_box: Vec<bool> = vec![false; n];
        let mut processed: Vec<bool> = vec![false; n];
        let mut queue: VecDeque<usize> = VecDeque::new();

        let mut total_candies = 0;

        for &box_idx_i32 in initial_boxes.iter() {
            let box_idx = box_idx_i32 as usize;
            has_box[box_idx] = true;
            if current_status[box_idx] {
                queue.push_back(box_idx);
            }
        }

        while let Some(current_box) = queue.pop_front() {
            if processed[current_box] {
                continue;
            }
            processed[current_box] = true;

            total_candies += candies[current_box];

            for &key_for_box_idx_i32 in keys[current_box].iter() {
                let key_for_box_idx = key_for_box_idx_i32 as usize;
                if !current_status[key_for_box_idx] {
                    current_status[key_for_box_idx] = true;
                    if has_box[key_for_box_idx] && !processed[key_for_box_idx] {
                        queue.push_back(key_for_box_idx);
                    }
                }
            }

            for &contained_box_idx_i32 in contained_boxes[current_box].iter() {
                let contained_box_idx = contained_box_idx_i32 as usize;
                if !has_box[contained_box_idx] {
                    has_box[contained_box_idx] = true;
                    if current_status[contained_box_idx] && !processed[contained_box_idx] {
                        queue.push_back(contained_box_idx);
                    }
                }
            }
        }

        total_candies
    }
}