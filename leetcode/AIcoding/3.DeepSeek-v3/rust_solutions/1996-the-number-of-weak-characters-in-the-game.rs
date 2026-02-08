impl Solution {
    pub fn number_of_weak_characters(properties: Vec<Vec<i32>>) -> i32 {
        let mut properties = properties;
        properties.sort_unstable_by(|a, b| {
            if a[0] == b[0] {
                b[1].cmp(&a[1])
            } else {
                a[0].cmp(&b[0])
            }
        });

        let mut stack: Vec<i32> = Vec::new();
        let mut res = 0;

        for prop in properties {
            while !stack.is_empty() && *stack.last().unwrap() < prop[1] {
                stack.pop();
                res += 1;
            }
            stack.push(prop[1]);
        }

        res
    }
}