use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn max_candies(
        status: Vec<i32>,
        candies: Vec<i32>,
        keys: Vec<Vec<i32>>,
        contained_boxes: Vec<Vec<i32>>,
        initial_boxes: Vec<i32>,
    ) -> i32 {
        let mut total_candies = 0;
        let mut queue = VecDeque::new();
        let mut owned_boxes = HashSet::new();
        let mut owned_keys = HashSet::new();
        let mut opened = vec![false; status.len()];

        for &box_id in &initial_boxes {
            if status[box_id as usize] == 1 {
                queue.push_back(box_id);
                opened[box_id as usize] = true;
            } else {
                owned_boxes.insert(box_id);
            }
        }

        while let Some(box_id) = queue.pop_front() {
            total_candies += candies[box_id as usize];

            for &key in &keys[box_id as usize] {
                owned_keys.insert(key);
                if owned_boxes.contains(&key) && !opened[key as usize] {
                    queue.push_back(key);
                    opened[key as usize] = true;
                }
            }

            for &contained_box in &contained_boxes[box_id as usize] {
                if status[contained_box as usize] == 1 || owned_keys.contains(&contained_box) {
                    if !opened[contained_box as usize] {
                        queue.push_back(contained_box);
                        opened[contained_box as usize] = true;
                    }
                } else {
                    owned_boxes.insert(contained_box);
                }
            }
        }

        total_candies
    }
}