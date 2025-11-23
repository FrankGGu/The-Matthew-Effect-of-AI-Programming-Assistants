struct Solution;

impl Solution {
    pub fn two_edit_words(mut queries: Vec<String>, dictionary: Vec<String>) -> Vec<String> {
        let mut result = Vec::new();
        for q in queries {
            let mut count = 0;
            for d in &dictionary {
                let mut diff = 0;
                for (a, b) in q.chars().zip(d.chars()) {
                    if a != b {
                        diff += 1;
                        if diff > 2 {
                            break;
                        }
                    }
                }
                if diff <= 2 {
                    count += 1;
                    break;
                }
            }
            if count > 0 {
                result.push(q);
            }
        }
        result
    }
}