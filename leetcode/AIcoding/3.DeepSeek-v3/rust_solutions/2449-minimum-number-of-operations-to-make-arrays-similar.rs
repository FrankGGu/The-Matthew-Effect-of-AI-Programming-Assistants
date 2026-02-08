impl Solution {
    pub fn make_similar(nums: Vec<i32>, target: Vec<i32>) -> i64 {
        let mut nums_even: Vec<i32> = nums.iter().filter(|&x| x % 2 == 0).cloned().collect();
        let mut nums_odd: Vec<i32> = nums.iter().filter(|&x| x % 2 != 0).cloned().collect();
        let mut target_even: Vec<i32> = target.iter().filter(|&x| x % 2 == 0).cloned().collect();
        let mut target_odd: Vec<i32> = target.iter().filter(|&x| x % 2 != 0).cloned().collect();

        nums_even.sort();
        nums_odd.sort();
        target_even.sort();
        target_odd.sort();

        let mut res = 0;

        for (a, b) in nums_even.iter().zip(target_even.iter()) {
            res += (a - b).abs() as i64;
        }

        for (a, b) in nums_odd.iter().zip(target_odd.iter()) {
            res += (a - b).abs() as i64;
        }

        res / 4
    }
}