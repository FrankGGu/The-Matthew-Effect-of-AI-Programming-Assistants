impl Solution {
    pub fn distinct_integers_after_reverse(nums: Vec<i32>) -> i32 {
        let mut distinct = nums.clone();
        distinct.sort_unstable();
        distinct.dedup();
        let mut count = distinct.len() as i32;

        for i in 0..nums.len() {
            let rev = nums[i].to_string().chars().rev().collect::<String>().parse::<i32>().unwrap();
            if !distinct.contains(&rev) && rev != nums[i] {
                count += 1;
            }
        }

        count
    }
}