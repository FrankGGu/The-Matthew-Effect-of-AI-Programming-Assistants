impl Solution {
    pub fn robot_string(s: String) -> String {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();

        // min_char_s[i] stores the minimum character in s_chars[i..n-1]
        // min_char_s[n] is a sentinel value ('{') to indicate no more characters in 's'.
        let mut min_char_s = vec!['z'; n + 1];
        min_char_s[n] = '{'; 

        for i in (0..n).rev() {
            min_char_s[i] = s_chars[i].min(min_char_s[i + 1]);
        }

        let mut res = String::new();
        let mut t_stack: Vec<char> = Vec::new(); 
        let mut s_ptr = 0;

        // Loop as long as there are characters remaining in 's' or 't_stack'.
        while s_ptr < n || !t_stack.is_empty() {
            // Determine the smallest character available from the remaining 's' string.
            // If 's' is exhausted (s_ptr == n), use the sentinel value.
            let min_from_s_suffix = if s_ptr < n {
                min_char_s[s_ptr]
            } else {
                '{' 
            };

            // While t_stack is not empty AND its top element is less than or equal to
            // the smallest character that can be obtained from the remaining 's'.
            // This means the top of t_stack is the best character to append to 'res' right now.
            while let Some(&top_t) = t_stack.last() {
                if top_t <= min_from_s_suffix {
                    res.push(t_stack.pop().unwrap());
                } else {
                    // If t_stack.last() is greater than min_from_s_suffix,
                    // we should wait for a smaller character from 's'.
                    break; 
                }
            }

            // If there are still characters in 's', push the current character onto t_stack.
            // This makes it available for future comparisons and potential popping.
            if s_ptr < n {
                t_stack.push(s_chars[s_ptr]);
                s_ptr += 1;
            }
        }

        res
    }
}