impl Solution {
    pub fn flip_and_invert_image(image: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        image.into_iter().map(|row| {
            row.into_iter().rev().map(|x| x ^ 1).collect()
        }).collect()
    }
}