pub fn robot_with_string(s: String) -> String {
    let mut s_chars: Vec<char> = s.chars().collect();
    let mut result = vec![];
    let mut stack = vec![];
    let mut count = [0; 26];

    for &c in &s_chars {
        count[(c as u8 - b'a') as usize] += 1;
    }

    for c in s_chars {
        stack.push(c);
        count[(c as u8 - b'a') as usize] -= 1;

        while let Some(&top) = stack.last() {
            if count[(top as u8 - b'a') as usize] == 0 {
                result.push(stack.pop().unwrap());
            } else if top < ('a' as char + count.iter().position(|&x| x > 0).unwrap() as u8) {
                break;
            } else {
                result.push(stack.pop().unwrap());
            }
        }
    }

    result.into_iter().collect()
}