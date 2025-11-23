impl Solution {
    pub fn k_increasing(arr: Vec<i32>, k: usize) -> i32 {
        let n = arr.len();
        let mut total_ops = 0;

        for start in 0..k {
            let mut subsequence = Vec::new();
            for i in (start..n).step_by(k) {
                subsequence.push(arr[i]);
            }
            total_ops += subsequence.len() as i32 - Self::length_of_lis(&subsequence);
        }

        total_ops
    }

    fn length_of_lis(nums: &[i32]) -> usize {
        let mut lis = Vec::new();
        for &num in nums {
            let pos = lis.binary_search(&num).unwrap_or_else(|x| x);
            if pos == lis.len() {
                lis.push(num);
            } else {
                lis[pos] = num;
            }
        }
        lis.len()
    }
}