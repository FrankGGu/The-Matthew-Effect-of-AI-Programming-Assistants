impl Solution {
    pub fn can_type(words: Vec<String>, keyboard: String) -> i32 {
        let mut available_keys = vec![0; 26];
        for c in keyboard.chars() {
            available_keys[(c as usize - 'a' as usize)] += 1;
        }

        let mut count = 0;
        for word in words {
            let mut can_type = true;
            let mut used_keys = vec![0; 26];
            for c in word.chars() {
                let idx = (c as usize - 'a' as usize);
                used_keys[idx] += 1;
                if used_keys[idx] > available_keys[idx] {
                    can_type = false;
                    break;
                }
            }
            if can_type {
                count += 1;
            }
        }
        count
    }
}