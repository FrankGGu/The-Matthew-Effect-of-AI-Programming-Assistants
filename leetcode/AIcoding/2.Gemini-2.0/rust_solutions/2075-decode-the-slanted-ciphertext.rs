impl Solution {
    pub fn decode_cipher_text(encoded_text: String, rows: i32) -> String {
        let encoded_bytes = encoded_text.as_bytes();
        let cols = encoded_bytes.len() as i32 / rows;
        let mut decoded_text = String::new();

        for start_col in 0..cols {
            let mut row = 0;
            let mut col = start_col;

            while row < rows && col < cols {
                decoded_text.push(encoded_bytes[(row * cols + col) as usize] as char);
                row += 1;
                col += 1;
            }
        }

        decoded_text.trim_end().to_string()
    }
}