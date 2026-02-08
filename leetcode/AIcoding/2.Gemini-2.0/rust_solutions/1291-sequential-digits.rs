impl Solution {
    pub fn sequential_digits(low: i32, high: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for start in 1..=9 {
            let mut num = start;
            let mut next = start + 1;
            while num <= high {
                if num >= low {
                    result.push(num);
                }
                if next > 9 {
                    break;
                }
                num = num * 10 + next;
                next += 1;
            }
        }
        result.sort();
        result
    }
}