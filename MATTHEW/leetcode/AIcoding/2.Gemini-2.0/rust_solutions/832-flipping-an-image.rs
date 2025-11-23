impl Solution {
    pub fn flip_and_invert_image(image: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        for row in image {
            let mut flipped_row = row.iter().rev().map(|&x| 1 - x).collect::<Vec<i32>>();
            result.push(flipped_row);
        }
        result
    }
}