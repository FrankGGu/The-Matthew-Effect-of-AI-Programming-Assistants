impl Solution {
    pub fn maximum_population(logs: Vec<Vec<i32>>) -> i32 {
        let mut population = [0; 101];
        for log in &logs {
            for i in log[0] - 1950..log[1] - 1950 {
                population[i as usize] += 1;
            }
        }
        let mut max_population = 0;
        let mut max_year = 0;
        for i in 0..101 {
            if population[i] > max_population {
                max_population = population[i];
                max_year = i;
            }
        }
        max_year + 1950
    }
}