impl Solution {
    pub fn nums_same_consec_diff(n: i32, k: i32) -> Vec<i32> {
        if n == 1 {
            return (0..10).collect();
        }

        let mut result = Vec::new();
        let mut queue = vec![i for i in 1..10];

        for _ in 1..n {
            let mut next_queue = Vec::new();
            for num in &queue {
                let last_digit = num % 10;
                if last_digit + k < 10 {
                    next_queue.push(num * 10 + last_digit + k);
                }
                if last_digit - k >= 0 {
                    next_queue.push(num * 10 + last_digit - k);
                }
            }
            queue = next_queue;
        }

        result.extend(queue);
        result
    }
}