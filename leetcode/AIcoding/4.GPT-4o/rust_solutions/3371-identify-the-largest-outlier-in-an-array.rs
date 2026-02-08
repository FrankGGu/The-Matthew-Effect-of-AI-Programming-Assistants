impl Solution {
    pub fn largest_outlier(arr: Vec<i32>) -> i32 {
        let mut count = vec![0; 3];
        for &num in &arr {
            count[(num % 3 + 3) as usize] += 1;
        }
        let outlier_mod = if count[1] > count[0] && count[1] > count[2] {
            1
        } else if count[2] > count[0] && count[2] > count[1] {
            2
        } else {
            0
        };
        *arr.iter().filter(|&&x| (x % 3 + 3) % 3 == outlier_mod).max().unwrap()
    }
}