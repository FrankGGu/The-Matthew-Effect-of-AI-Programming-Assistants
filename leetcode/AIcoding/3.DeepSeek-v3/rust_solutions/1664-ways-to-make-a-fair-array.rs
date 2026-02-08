impl Solution {
    pub fn ways_to_make_fair(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix_odd = vec![0; n + 1];
        let mut prefix_even = vec![0; n + 1];

        for i in 0..n {
            prefix_odd[i + 1] = prefix_odd[i];
            prefix_even[i + 1] = prefix_even[i];
            if i % 2 == 0 {
                prefix_even[i + 1] += nums[i];
            } else {
                prefix_odd[i + 1] += nums[i];
            }
        }

        let mut res = 0;
        for i in 0..n {
            let even_sum = prefix_even[i] + (prefix_odd[n] - prefix_odd[i + 1]);
            let odd_sum = prefix_odd[i] + (prefix_even[n] - prefix_even[i + 1]);
            if even_sum == odd_sum {
                res += 1;
            }
        }
        res
    }
}