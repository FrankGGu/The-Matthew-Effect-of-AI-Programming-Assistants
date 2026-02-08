impl Solution {
    pub fn divisibility_array(word: String, m: i32) -> Vec<i32> {
        let mut result = vec![0; word.len()];
        let mut current_num = 0;

        for (i, c) in word.chars().enumerate() {
            current_num = (current_num * 10 + (c as i32 - '0' as i32)) % m;
            if (i + 1) as i32 % m == current_num {
                result[i] = 1;
            }
        }

        result
    }
}