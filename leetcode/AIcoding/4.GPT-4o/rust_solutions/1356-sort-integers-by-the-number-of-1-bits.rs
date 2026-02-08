impl Solution {
    pub fn sort_by_bits(arr: Vec<i32>) -> Vec<i32> {
        let mut arr = arr;
        arr.sort_by(|&a, &b| {
            let count_a = a.count_ones();
            let count_b = b.count_ones();
            if count_a == count_b {
                a.cmp(&b)
            } else {
                count_a.cmp(&count_b)
            }
        });
        arr
    }
}