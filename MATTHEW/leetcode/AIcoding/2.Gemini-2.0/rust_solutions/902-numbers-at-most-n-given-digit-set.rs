impl Solution {
    pub fn at_most_n_given_digit_set(digits: Vec<String>, n: i32) -> i32 {
        let s = n.to_string();
        let k = s.len();
        let mut res = 0;
        for i in 1..k {
            res += digits.len().pow(i as u32) as i32;
        }

        let mut i = 0;
        while i < k {
            let mut has_same_num = false;
            for &d in &digits {
                let digit = d.chars().next().unwrap();
                let target = s.chars().nth(i).unwrap();
                if digit < target {
                    res += digits.len().pow((k - i - 1) as u32) as i32;
                } else if digit == target {
                    has_same_num = true;
                    if i == k - 1 {
                        res += 1;
                    }
                    break;
                }
            }
            if !has_same_num {
                return res;
            }
            i += 1;
        }

        res
    }
}