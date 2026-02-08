impl Solution {
    pub fn number_of_weak_characters(properties: Vec<Vec<i32>>) -> i32 {
        let mut properties = properties;
        properties.sort_by(|a, b| a[0].cmp(&b[0]).then(b[1].cmp(&a[1])));

        let mut count = 0;
        let mut max_defense = 0;

        for prop in properties {
            if prop[1] < max_defense {
                count += 1;
            } else {
                max_defense = prop[1];
            }
        }

        count
    }
}