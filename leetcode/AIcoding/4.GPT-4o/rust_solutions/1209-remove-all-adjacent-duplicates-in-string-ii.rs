pub fn remove_duplicates(s: String, k: i32) -> String {
    let mut stack: Vec<(char, usize)> = Vec::new();
    let k = k as usize;

    for ch in s.chars() {
        if let Some((last_char, count)) = stack.last_mut() {
            if *last_char == ch {
                *count += 1;
                if *count == k {
                    stack.pop();
                }
            } else {
                stack.push((ch, 1));
            }
        } else {
            stack.push((ch, 1));
        }
    }

    stack.iter().map(|(c, count)| c.to_string().repeat(*count)).collect()
}