struct Solution;

impl Solution {
    pub fn max_population_year(logs: Vec<Vec<i32>>) -> i32 {
        let mut years_population_change = vec![0; 101]; 
        let start_year = 1950;

        for log in logs {
            let birth_year = log[0];
            let death_year = log[1];

            years_population_change[(birth_year - start_year) as usize] += 1;
            years_population_change[(death_year - start_year) as usize] -= 1;
        }

        let mut current_population = 0;
        let mut max_population = 0;
        let mut max_pop_year = start_year;

        for i in 0..years_population_change.len() {
            current_population += years_population_change[i];
            let year = start_year + i as i32;

            if current_population > max_population {
                max_population = current_population;
                max_pop_year = year;
            }
        }

        max_pop_year
    }
}