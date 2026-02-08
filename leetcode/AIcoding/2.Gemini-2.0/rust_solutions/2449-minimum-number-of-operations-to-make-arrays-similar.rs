impl Solution {
    pub fn make_similar(nums: Vec<i32>, target: Vec<i32>) -> i64 {
        let mut nums_odd = Vec::new();
        let mut nums_even = Vec::new();
        let mut target_odd = Vec::new();
        let mut target_even = Vec::new();

        for &num in &nums {
            if num % 2 == 0 {
                nums_even.push(num);
            } else {
                nums_odd.push(num);
            }
        }

        for &num in &target {
            if num % 2 == 0 {
                target_even.push(num);
            } else {
                target_odd.push(num);
            }
        }

        nums_odd.sort();
        nums_even.sort();
        target_odd.sort();
        target_even.sort();

        let mut ans: i64 = 0;
        for i in 0..nums_odd.len() {
            if nums_odd[i] > target_odd[i] {
                ans += (nums_odd[i] - target_odd[i]) as i64 / 2;
            }
        }

        for i in 0..nums_even.len() {
            if nums_even[i] > target_even[i] {
                ans += (nums_even[i] - target_even[i]) as i64 / 2;
            }
        }
        ans
    }
}