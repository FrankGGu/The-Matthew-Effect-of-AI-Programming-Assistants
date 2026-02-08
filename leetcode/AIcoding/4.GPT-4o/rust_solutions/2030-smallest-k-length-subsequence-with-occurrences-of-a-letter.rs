pub fn smallest_k_length_subsequence(s: String, k: i32, letter: char, repetition: i32) -> String {
    let n = s.len();
    let k = k as usize;
    let repetition = repetition as usize;
    let mut count = 0;
    let mut letter_count = 0;
    let mut result = vec![];
    let mut stack = vec![];

    for c in s.chars() {
        if c == letter {
            letter_count += 1;
        }
    }

    for (i, c) in s.chars().enumerate() {
        while !stack.is_empty() && 
              (stack.last().unwrap() > &c) && 
              (stack.len() - 1 + n - i > k) && 
              (stack.len() > 0 || letter_count > repetition) {
            if stack.last().unwrap() == &letter {
                if letter_count - 1 >= repetition {
                    break;
                }
            }
            stack.pop();
        }

        if stack.len() < k {
            if c == letter {
                stack.push(c);
                letter_count -= 1;
            } else if k - stack.len() > repetition {
                stack.push(c);
            } else if repetition > 0 {
                stack.push(c);
            }
        }

        if c == letter {
            letter_count -= 1;
        }
        n -= 1;
    }

    for c in stack.iter().take(k) {
        result.push(*c);
    }

    result.iter().collect()
}