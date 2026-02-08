impl Solution {
    pub fn count_special_integers(n: i32) -> i32 {
        let s = n.to_string();
        let len = s.len();
        let mut count = 0;

        for i in 1..len {
            count += 9 * (10_i32.pow(i as u32 - 1));
            for j in 1..10 {
                count += (10_i32.pow(len as u32 - i as u32 - 1)) * (9_i32.pow(i as u32 - 1));
            }
        }

        let mut used = std::collections::HashSet::new();
        for i in 0..len {
            let digit = s.chars().nth(i).unwrap().to_digit(10).unwrap() as i32;
            for j in 0..digit {
                if !used.contains(&(j as u8)) {
                    count += (10_i32.pow(len as u32 - i as u32 - 1)) * (9_i32.pow (i as u32));
                }
            }
            if used.contains(&(digit as u8)) {
                break;
            }
            used.insert(digit as u8);
        }

        count + 1
    }
}