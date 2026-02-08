impl Solution {
    pub fn decode_ciphertext(ciphertext: String, rows: i32) -> String {
        let cols = (ciphertext.len() + rows as usize - 1) / rows as usize;
        let mut result = String::new();

        for i in 0..cols {
            let mut j = 0;
            while j < rows && (i + j) < cols {
                let index = (j * cols + i) as usize;
                if index < ciphertext.len() {
                    result.push(ciphertext.chars().nth(index).unwrap());
                }
                j += 1;
            }
        }

        result.trim_end().to_string()
    }
}