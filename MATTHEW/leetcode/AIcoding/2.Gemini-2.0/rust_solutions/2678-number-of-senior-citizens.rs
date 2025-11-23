impl Solution {
    pub fn count_senior_citizens(details: Vec<String>) -> i32 {
        let mut count = 0;
        for detail in details {
            let age = detail[11..13].parse::<i32>().unwrap();
            if age > 60 {
                count += 1;
            }
        }
        count
    }
}