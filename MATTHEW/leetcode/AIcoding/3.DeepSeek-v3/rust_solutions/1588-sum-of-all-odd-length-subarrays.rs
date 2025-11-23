impl Solution {
    pub fn sum_odd_length_subarrays(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut total = 0;

        for i in 0..n {
            for j in i..n {
                if (j - i + 1) % 2 == 1 {
                    total += arr[i..=j].iter().sum::<i32>();
                }
            }
        }

        total
    }
}