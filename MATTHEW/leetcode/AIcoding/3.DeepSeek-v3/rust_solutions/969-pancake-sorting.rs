impl Solution {
    pub fn pancake_sort(mut arr: Vec<i32>) -> Vec<i32> {
        let mut res = Vec::new();
        let n = arr.len();
        for i in (0..n).rev() {
            let max_pos = arr[..=i].iter().position(|&x| x == (i + 1) as i32).unwrap();
            if max_pos != i {
                if max_pos != 0 {
                    arr[..=max_pos].reverse();
                    res.push((max_pos + 1) as i32);
                }
                arr[..=i].reverse();
                res.push((i + 1) as i32);
            }
        }
        res
    }
}