impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn maximum_population(people: Vec<Vec<i32>>) -> i32 {
        let mut map = HashMap::new();
        for p in people {
            let birth = p[0];
            let death = p[1];
            *map.entry(birth).or_insert(0) += 1;
            *map.entry(death).or_insert(0) -= 1;
        }

        let mut max_pop = 0;
        let mut current_pop = 0;
        let mut result_year = 0;

        for year in 1950..2051 {
            current_pop += *map.get(&year).unwrap_or(&0);
            if current_pop > max_pop {
                max_pop = current_pop;
                result_year = year;
            }
        }

        result_year
    }
}
}