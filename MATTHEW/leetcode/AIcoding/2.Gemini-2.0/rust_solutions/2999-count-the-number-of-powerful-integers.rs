impl Solution {
    pub fn count_powerful_integers(start: i64, finish: i64, power: i64, suffix: i64) -> i64 {
        let s = start.to_string();
        let f = finish.to_string();
        let suffix_str = suffix.to_string();
        let n = suffix_str.len();

        let count = |num_str: String| -> i64 {
            let m = num_str.len();
            if m < n {
                return 0;
            }

            let num_suffix = num_str[(m - n)..].to_string();
            if num_suffix.parse::<i64>().unwrap() != suffix {
                return 0;
            }

            let mut ans = 0;
            let mut equal = true;
            for i in 0..(m - n) {
                let digit = num_str.chars().nth(i).unwrap().to_digit(10).unwrap() as i64;
                if equal {
                    for d in 0..digit {
                        if i == 0 && d == 0 {
                            continue;
                        }
                        ans += Self::count_rest(m - n - i - 1);
                    }

                    if digit > 0 {
                        ans += Self::count_rest(m - n - i - 1);
                    }

                    if d > digit {
                        equal = false;
                        break;
                    }
                    if digit > power {
                        equal = false;
                        break;
                    }

                    if digit < power {
                        continue;
                    }
                } else {
                    break;
                }

                if digit != power {
                    equal = false;
                    break;
                }
            }

            if equal {
                ans += 1;
            }
            ans
        };

        let start_val = start.to_string();
        let finish_val = finish.to_string();

        count(finish_val) - count((start - 1).to_string())
    }

    fn count_rest(len: usize) -> i64 {
        if len == 0 {
            return 1;
        }
        let mut ans = 1;
        for _ in 0..len {
            ans *= 10;
        }
        ans
    }
}