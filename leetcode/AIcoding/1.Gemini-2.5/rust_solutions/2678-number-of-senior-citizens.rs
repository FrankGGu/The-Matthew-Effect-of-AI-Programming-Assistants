impl Solution {
    pub fn count_seniors(details: Vec<String>) -> i32 {
        let mut senior_count = 0;
        for detail in details {
            let age_str = &detail[11..13];
            if let Ok(age) = age_str.parse::<i32>() {
                if age > 60 {
                    senior_count += 1;
                }
            }
        }
        senior_count
    }
}