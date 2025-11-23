impl Solution {
    pub fn count_points(rings: String) -> i32 {
        let mut rods: Vec<String> = vec!["".to_string(); 10];
        let chars: Vec<char> = rings.chars().collect();
        for i in (0..chars.len()).step_by(2) {
            let color = chars[i];
            let rod_index = chars[i + 1].to_digit(10).unwrap() as usize;
            if !rods[rod_index].contains(color) {
                rods[rod_index].push(color);
            }
        }

        let mut count = 0;
        for rod in rods {
            if rod.len() == 3 {
                count += 1;
            }
        }

        count
    }
}