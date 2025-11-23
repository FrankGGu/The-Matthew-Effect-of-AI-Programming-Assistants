impl Solution {
    pub fn odd_string(words: Vec<String>) -> String {
        fn get_diff_array(s: &str) -> Vec<i32> {
            let chars: Vec<i32> = s.chars().map(|c| c as i32).collect();
            let mut diffs = Vec::with_capacity(chars.len() - 1);
            for i in 0..(chars.len() - 1) {
                diffs.push(chars[i+1] - chars[i]);
            }
            diffs
        }

        let diff0 = get_diff_array(&words[0]);
        let diff1 = get_diff_array(&words[1]);
        let diff2 = get_diff_array(&words[2]);

        if diff0 == diff1 {
            let common_diff = diff0;
            for i in 2..words.len() {
                let current_diff = get_diff_array(&words[i]);
                if current_diff != common_diff {
                    return words[i].clone();
                }
            }
            unreachable!(); 
        } else if diff0 == diff2 {
            words[1].clone()
        } else {
            words[0].clone()
        }
    }
}