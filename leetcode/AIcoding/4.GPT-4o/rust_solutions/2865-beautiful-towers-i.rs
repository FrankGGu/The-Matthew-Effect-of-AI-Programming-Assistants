impl Solution {
    pub fn beautiful_towers(n: i32, heights: Vec<i32>) -> i32 {
        let mut max_height = 0;
        let mut count = 0;

        for &height in &heights {
            if height > max_height {
                count += 1;
                max_height = height;
            }
        }

        count
    }
}