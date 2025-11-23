use std::collections::BTreeMap;

struct FallingSquares;

impl FallingSquares {
    pub fn falling_squares(positions: Vec<Vec<i32>>) -> Vec<i32> {
        let mut heights = BTreeMap::new();
        let mut max_height = 0;
        let mut results = Vec::new();

        for position in positions {
            let (left, size) = (position[0], position[1]);
            let right = left + size;
            let mut current_height = 0;

            for (&key, &value) in heights.range(left..right) {
                current_height = current_height.max(value);
            }

            let new_height = current_height + size;
            heights.insert(left, new_height);
            for i in left + 1..right {
                heights.insert(i, new_height);
            }

            max_height = max_height.max(new_height);
            results.push(max_height);
        }

        results
    }
}