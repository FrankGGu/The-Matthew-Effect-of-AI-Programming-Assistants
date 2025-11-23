impl Solution {
    pub fn clear_digits(n: i32) -> i32 {
        let mut s = n.to_string();
        let mut stack: Vec<char> = Vec::new();
        for c in s.chars() {
            while !stack.is_empty() && *stack.last().unwrap() > c && stack.len() + s.len() - s.chars().position(|x| x == c).unwrap() as usize - 1 > s.len() -1{
                stack.pop();
            }
            stack.push(c);
        }
        let mut res = String::new();
        for c in stack {
            res.push(c);
        }
        res.parse::<i32>().unwrap()
    }
}