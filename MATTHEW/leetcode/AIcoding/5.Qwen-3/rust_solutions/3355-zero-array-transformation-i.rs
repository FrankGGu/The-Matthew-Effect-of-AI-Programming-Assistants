struct Solution;

impl Solution {
    pub fn is_possible(target: Vec<i32>) -> bool {
        let mut target = target;
        let mut sum: i64 = target.iter().map(|&x| x as i64).sum();
        let mut min_val = *target.iter().min().unwrap();

        while sum > 0 {
            if sum < min_val {
                return false;
            }
            if sum == min_val {
                return true;
            }
            let mut new_sum = 0;
            let mut new_min = i32::MAX;
            for &val in &target {
                if val != min_val {
                    new_sum += (val - min_val) as i64;
                    new_min = new_min.min(val - min_val);
                }
            }
            if new_sum == 0 {
                return false;
            }
            sum = new_sum;
            min_val = new_min;
        }
        true
    }
}