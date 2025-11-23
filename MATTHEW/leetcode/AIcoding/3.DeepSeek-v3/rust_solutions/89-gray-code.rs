impl Solution {
    pub fn gray_code(n: i32) -> Vec<i32> {
        let mut res = vec![0];
        for i in 0..n {
            let mut tmp = res.iter().rev().map(|&x| x | (1 << i)).collect();
            res.append(&mut tmp);
        }
        res
    }
}