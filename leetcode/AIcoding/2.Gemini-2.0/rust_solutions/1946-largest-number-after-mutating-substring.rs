impl Solution {
    pub fn maximum_number(num: String, change: Vec<i32>) -> String {
        let mut chars: Vec<char> = num.chars().collect();
        let mut changed = false;

        for i in 0..chars.len() {
            let digit = chars[i].to_digit(10).unwrap() as usize;
            if change[digit] as u32 > digit as u32 {
                chars[i] = char::from_digit(change[digit] as u32, 10).unwrap();
                changed = true;
            } else if change[digit] as u32 == digit as u32 {
                if changed {
                    continue;
                }
            }
            else if changed {
                break;
            }
            else {
                continue;
            }
        }

        if changed {
            let mut changed_end = false;
            for i in 0..chars.len() {
                let digit = chars[i].to_digit(10).unwrap() as usize;
                if change[digit] as u32 >= digit as u32 {
                    chars[i] = char::from_digit(change[digit] as u32, 10).unwrap();
                    changed_end = true;
                } else {
                    if changed_end {
                        break;
                    }
                }
            }
        } else {
           for i in 0..chars.len() {
                let digit = chars[i].to_digit(10).unwrap() as usize;
                if change[digit] as u32 > digit as u32 {
                    chars[i] = char::from_digit(change[digit] as u32, 10).unwrap();
                     let mut changed_end = true;
                    for j in i+1..chars.len() {
                         let digit2 = chars[j].to_digit(10).unwrap() as usize;
                         if change[digit2] as u32 >= digit2 as u32 {
                            chars[j] = char::from_digit(change[digit2] as u32, 10).unwrap();
                         } else {
                             break;
                         }

                    }
                    break;
                }
           }
        }

        chars.into_iter().collect()
    }
}