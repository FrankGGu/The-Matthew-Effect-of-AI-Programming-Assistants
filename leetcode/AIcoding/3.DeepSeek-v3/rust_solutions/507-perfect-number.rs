impl Solution {
    pub fn check_perfect_number(num: i32) -> bool {
        if num <= 1 {
            return false;
        }
        let mut sum = 1;
        let sqrt_num = (num as f64).sqrt() as i32;
        for i in 2..=sqrt_num {
            if num % i == 0 {
                sum += i;
                let complement = num / i;
                if complement != i {
                    sum += complement;
                }
            }
        }
        sum == num
    }
}