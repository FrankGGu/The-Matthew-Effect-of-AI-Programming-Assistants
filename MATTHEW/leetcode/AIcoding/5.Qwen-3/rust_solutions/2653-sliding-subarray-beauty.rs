pub struct Solution {}

impl Solution {
    pub fn get_subarray_beauty(arr: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n = arr.len();
        let mut result = Vec::new();
        let mut freq = vec![0; 101]; // since 1 <= arr[i] <= 100

        for i in 0..k {
            freq[arr[i] as usize] += 1;
        }

        for i in 0..n - k + 1 {
            if i > 0 {
                freq[arr[i - 1] as usize] -= 1;
                freq[arr[i + k - 1] as usize] += 1;
            }

            let mut beauty = 0;
            for j in 1..=100 {
                if freq[j] > 0 {
                    beauty = j as i32;
                    break;
                }
            }
            result.push(beauty);
        }

        result
    }
}