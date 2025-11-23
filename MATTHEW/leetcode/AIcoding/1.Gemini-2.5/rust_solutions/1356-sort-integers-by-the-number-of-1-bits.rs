impl Solution {
    pub fn sort_by_bits(mut arr: Vec<i32>) -> Vec<i32> {
        arr.sort_by(|&a, &b| {
            let ones_a = (a as u32).count_ones();
            let ones_b = (b as u32).count_ones();
            if ones_a != ones_b {
                ones_a.cmp(&ones_b)
            } else {
                a.cmp(&b)
            }
        });
        arr
    }
}