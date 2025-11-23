impl Solution {
    pub fn count_numbers_with_non_decreasing_digits(n: i32) -> i32 {
        let digits = (n + 1).to_string().len();
        let mut count = 0;

        for i in 1..digits {
            count += 9 * combination(9, i as usize);
        }

        let mut prev_digit = 0;
        let mut remaining_digits = n;

        for i in 0..digits {
            let current_digit = (remaining_digits % 10) as usize;
            remaining_digits /= 10;

            for j in prev_digit..current_digit {
                count += combination(9 - j, digits - i - 1);
            }

            if current_digit < prev_digit {
                break;
            }
            prev_digit = current_digit;
        }

        count + 1
    }
}

fn combination(n: usize, k: usize) -> i32 {
    if k > n {
        return 0;
    }
    let mut res = 1;
    let mut k = k;
    if k > n - k {
        k = n - k;
    }
    for i in 0..k {
        res = res * (n - i) as i32 / (i + 1) as i32;
    }
    res
}