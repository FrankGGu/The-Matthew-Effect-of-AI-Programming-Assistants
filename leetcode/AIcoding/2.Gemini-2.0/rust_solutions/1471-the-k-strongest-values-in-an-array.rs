impl Solution {
    pub fn get_strongest(arr: Vec<i32>, k: i32) -> Vec<i32> {
        let mut arr = arr;
        arr.sort();
        let n = arr.len();
        let median = arr[ (n - 1) / 2];

        let mut strong_values: Vec<(i32, i32)> = arr.iter().map(|&x| (x, (x - median).abs())).collect();

        strong_values.sort_by(|a, b| {
            if a.1 != b.1 {
                b.1.cmp(&a.1)
            } else {
                b.0.cmp(&a.0)
            }
        });

        let mut result: Vec<i32> = Vec::new();
        for i in 0..k as usize {
            result.push(strong_values[i].0);
        }

        result
    }
}