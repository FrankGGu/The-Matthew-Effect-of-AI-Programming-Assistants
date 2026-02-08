impl Solution {
    pub fn num_of_subarrays(arr: Vec<i32>) -> i32 {
        let mut odd = 0;
        let mut even = 1;
        let mut sum = 0;
        let mut res = 0;
        let modulo = 1_000_000_007;

        for num in arr {
            sum += num;
            if sum % 2 == 1 {
                res += even;
                odd += 1;
            } else {
                res += odd;
                even += 1;
            }
            res %= modulo;
        }

        res
    }
}