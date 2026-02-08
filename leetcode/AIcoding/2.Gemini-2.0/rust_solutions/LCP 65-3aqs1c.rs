impl Solution {
    pub fn comfortable_numbers(l: i32, r: i32) -> i32 {
        let mut count = 0;
        for i in l..=r {
            for j in i + 1..=r {
                if i <= j && Self::is_comfortable(i, j) && Self::is_comfortable(j, i) {
                    count += 1;
                }
            }
        }
        count
    }

    fn is_comfortable(a: i32, b: i32) -> bool {
        let sum_digits = |mut n: i32| {
            let mut sum = 0;
            while n > 0 {
                sum += n % 10;
                n /= 10;
            }
            sum
        };

        let sum_a = sum_digits(a);
        (a - b).abs() <= sum_a
    }
}