impl Solution {
    pub fn closest_divisors(num: i32) -> Vec<i32> {
        let num1 = num + 1;
        let num2 = num + 2;
        let (a1, b1) = Self::find_closest_divisors(num1);
        let (a2, b2) = Self::find_closest_divisors(num2);
        if (a1 - b1).abs() <= (a2 - b2).abs() {
            vec![a1, b1]
        } else {
            vec![a2, b2]
        }
    }

    fn find_closest_divisors(num: i32) -> (i32, i32) {
        let sqrt_num = (num as f64).sqrt() as i32;
        for i in (1..=sqrt_num).rev() {
            if num % i == 0 {
                return (i, num / i);
            }
        }
        (1, num)
    }
}