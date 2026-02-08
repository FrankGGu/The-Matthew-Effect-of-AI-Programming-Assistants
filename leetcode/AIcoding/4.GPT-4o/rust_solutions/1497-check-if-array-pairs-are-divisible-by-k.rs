impl Solution {
    pub fn can_arrange(arr: Vec<i32>, k: i32) -> bool {
        let mut count = vec![0; k as usize];
        for &num in &arr {
            count[(num % k + k) as usize % k] += 1;
        }
        for i in 1..(k / 2 + 1) {
            if count[i as usize] != count[(k - i) as usize] {
                return false;
            }
        }
        count[0] % 2 == 0
    }
}