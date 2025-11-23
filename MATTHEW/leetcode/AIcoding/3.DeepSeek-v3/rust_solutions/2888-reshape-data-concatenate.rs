impl Solution {
    pub fn concatenate_tables(frames: Vec<Vec<Vec<i32>>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        for frame in frames {
            for row in frame {
                result.push(row);
            }
        }
        result
    }
}