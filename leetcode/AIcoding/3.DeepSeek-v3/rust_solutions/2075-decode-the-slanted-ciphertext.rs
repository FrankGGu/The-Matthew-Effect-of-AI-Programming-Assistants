impl Solution {
    pub fn decode_ciphertext(encoded_text: String, rows: i32) -> String {
        let encoded_text: Vec<char> = encoded_text.chars().collect();
        let rows = rows as usize;
        if rows == 0 || encoded_text.is_empty() {
            return String::new();
        }
        let cols = encoded_text.len() / rows;
        let mut res = Vec::new();
        for i in 0..cols {
            let mut row = 0;
            let mut col = i;
            while row < rows && col < cols {
                res.push(encoded_text[row * cols + col]);
                row += 1;
                col += 1;
            }
        }
        while let Some(&c) = res.last() {
            if c == ' ' {
                res.pop();
            } else {
                break;
            }
        }
        res.into_iter().collect()
    }
}