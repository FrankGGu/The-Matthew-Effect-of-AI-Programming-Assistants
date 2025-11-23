impl Solution {
    pub fn maximum_population(logs: Vec<Vec<i32>>) -> i32 {
        let mut year_population = vec![0; 2051];

        for log in logs {
            year_population[log[0] as usize] += 1;
            year_population[log[1] as usize] -= 1;
        }

        let mut max_population = 0;
        let mut max_year = 0;
        let mut current_population = 0;

        for year in 1950..=2050 {
            current_population += year_population[year as usize];
            if current_population > max_population {
                max_population = current_population;
                max_year = year;
            }
        }

        max_year
    }
}