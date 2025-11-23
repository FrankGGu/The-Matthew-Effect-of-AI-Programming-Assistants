impl Solution {
    pub fn predict_party_victory(senate: String) -> String {
        let mut radiant = std::collections::VecDeque::new();
        let mut dire = std::collections::VecDeque::new();
        let n = senate.len();

        for (i, c) in senate.chars().enumerate() {
            if c == 'R' {
                radiant.push_back(i);
            } else {
                dire.push_back(i);
            }
        }

        while !radiant.is_empty() && !dire.is_empty() {
            let r = radiant.pop_front().unwrap();
            let d = dire.pop_front().unwrap();

            if r < d {
                radiant.push_back(r + n);
            } else {
                dire.push_back(d + n);
            }
        }

        if radiant.is_empty() {
            "Dire".to_string()
        } else {
            "Radiant".to_string()
        }
    }
}