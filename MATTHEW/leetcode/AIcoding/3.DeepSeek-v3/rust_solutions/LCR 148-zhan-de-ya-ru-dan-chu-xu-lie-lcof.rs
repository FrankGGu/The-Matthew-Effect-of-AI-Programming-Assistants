impl Solution {
    pub fn validate_book_sequences(put_in: Vec<i32>, take_out: Vec<i32>) -> bool {
        let mut stack = Vec::new();
        let mut i = 0;
        for &num in put_in.iter() {
            stack.push(num);
            while !stack.is_empty() && stack.last() == take_out.get(i) {
                stack.pop();
                i += 1;
            }
        }
        stack.is_empty() && i == take_out.len()
    }
}