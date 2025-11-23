impl Solution {
    pub fn closest_to_target(arr: Vec<i32>, target: i32) -> i32 {
        let mut res = i32::MAX;
        let mut current = vec![];
        for num in arr {
            current = current.iter().map(|&x| x & num).collect();
            current.push(num);
            current.sort();
            current.dedup();
            for &val in &current {
                if (val - target).abs() < res.abs() {
                    res = val - target;
                }
            }
        }
        res.abs()
    }
}