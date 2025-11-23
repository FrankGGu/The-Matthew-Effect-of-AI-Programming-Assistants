struct Solution;

impl Solution {
    fn count_digits(mut num: i32) -> [u8; 10] {
        let mut counts = [0; 10];
        if num == 0 {
            counts[0] = 1;
            return counts;
        }
        while num > 0 {
            counts[(num % 10) as usize] += 1;
            num /= 10;
        }
        counts
    }

    pub fn is_reordered_power_of_2(n: i32) -> bool {
        let n_counts = Self::count_digits(n);

        for i in 0..31 {
            let power_of_2 = 1 << i;
            let power_counts = Self::count_digits(power_of_2);
            if n_counts == power_counts {
                return true;
            }
        }

        false
    }
}