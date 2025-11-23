impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>) -> i32 {
        let mut even = 1;
        let mut odd = 0;
        let mut ans = 0;
        let modulo = 1_000_000_007;

        for &num in &arr {
            if num % 2 == 0 {
                even += 1;
            } else {
                let temp = even;
                even = odd;
                odd = temp;
                odd += 1;
            }

            ans = (ans + odd) % modulo;
        }

        ans
    }
}