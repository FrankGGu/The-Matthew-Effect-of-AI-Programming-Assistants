impl Solution {
    pub fn count_covered_buildings(positions: Vec<Vec<i32>>) -> Vec<i32> {
        let mut events: Vec<(i32, i32)> = Vec::new();
        for pos in &positions {
            events.push((pos[0], 1));
            events.push((pos[1] + 1, -1));
        }

        events.sort();

        let mut result: Vec<i32> = vec![0; positions.len() + 1];
        let mut count = 0;
        let mut last_pos = 0;

        for (pos, type_) in events {
            result[count as usize] += pos - last_pos;
            count += type_;
            last_pos = pos;
        }

        let mut final_result: Vec<i32> = Vec::new();
        for i in 1..result.len() {
            if result[i] > 0 {
                final_result.push(result[i]);
            }
        }

        final_result
    }
}