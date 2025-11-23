struct Solution;

impl Solution {
    pub fn flip_and_invert_image(mut image: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        for row in &mut image {
            let len = row.len();
            for i in 0..(len + 1) / 2 {
                let j = len - 1 - i;
                let temp = row[i];
                row[i] = row[j];
                row[j] = temp;
            }
            for val in row {
                *val ^= 1;
            }
        }
        image
    }
}