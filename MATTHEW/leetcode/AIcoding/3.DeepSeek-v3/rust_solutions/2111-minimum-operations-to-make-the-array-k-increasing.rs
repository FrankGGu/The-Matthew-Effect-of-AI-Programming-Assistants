impl Solution {
    pub fn k_increasing(arr: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = arr.len();
        let mut res = 0;
        for i in 0..k {
            let mut sub = Vec::new();
            let mut j = i;
            while j < n {
                sub.push(arr[j]);
                j += k;
            }
            res += sub.len() as i32 - Self::length_of_lis(&sub);
        }
        res
    }

    fn length_of_lis(nums: &[i32]) -> i32 {
        let mut tails = Vec::new();
        for &num in nums {
            if let Err(i) = tails.binary_search(&num) {
                if i == tails.len() {
                    tails.push(num);
                } else {
                    tails[i] = num;
                }
            }
        }
        tails.len() as i32
    }
}