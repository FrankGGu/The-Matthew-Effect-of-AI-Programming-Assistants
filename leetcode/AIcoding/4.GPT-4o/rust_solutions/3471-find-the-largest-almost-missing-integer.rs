impl Solution {
    pub fn find_largest_missing_integer(arr: Vec<i32>) -> i32 {
        let mut present = vec![false; 1001];
        for &num in &arr {
            if num > 0 && num <= 1000 {
                present[num as usize] = true;
            }
        }
        for i in (1..=1000).rev() {
            if !present[i] {
                return i;
            }
        }
        -1
    }
}