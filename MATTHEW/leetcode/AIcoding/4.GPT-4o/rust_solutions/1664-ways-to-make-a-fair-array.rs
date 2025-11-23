impl Solution {
    pub fn ways_to_make_fair(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut odd_sum = 0;
        let mut even_sum = 0;

        for i in 0..n {
            if i % 2 == 0 {
                even_sum += arr[i];
            } else {
                odd_sum += arr[i];
            }
        }

        let mut res = 0;
        let mut current_even = 0;
        let mut current_odd = 0;

        for i in 0..n {
            if i % 2 == 0 {
                even_sum -= arr[i];
            } else {
                odd_sum -= arr[i];
            }

            if current_even + odd_sum == current_odd + even_sum {
                res += 1;
            }

            if i % 2 == 0 {
                current_even += arr[i];
            } else {
                current_odd += arr[i];
            }
        }

        res
    }
}