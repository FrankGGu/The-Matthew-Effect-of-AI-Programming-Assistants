impl Solution {
    pub fn maximum_gain(s: String, x: i32, y: i32) -> i32 {
        let mut stack = Vec::new();
        let mut res = 0;
        let (first, second, score_first, score_second) = if x >= y {
            ('a', 'b', x, y)
        } else {
            ('b', 'a', y, x)
        };

        for c in s.chars() {
            if !stack.is_empty() && stack.last() == Some(&first) && c == second {
                stack.pop();
                res += score_first;
            } else {
                stack.push(c);
            }
        }

        let mut new_stack = Vec::new();
        for c in stack {
            if !new_stack.is_empty() && new_stack.last() == Some(&second) && c == first {
                new_stack.pop();
                res += score_second;
            } else {
                new_stack.push(c);
            }
        }

        res
    }
}