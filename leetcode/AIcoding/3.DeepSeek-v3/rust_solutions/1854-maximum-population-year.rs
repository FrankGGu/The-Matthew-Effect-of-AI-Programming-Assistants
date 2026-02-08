impl Solution {
    pub fn maximum_population(logs: Vec<Vec<i32>>) -> i32 {
        let mut years = vec![0; 101];
        for log in logs {
            let (birth, death) = (log[0], log[1]);
            for year in birth..death {
                let idx = (year - 1950) as usize;
                years[idx] += 1;
            }
        }

        let mut max_pop = 0;
        let mut max_year = 1950;
        for (i, &pop) in years.iter().enumerate() {
            if pop > max_pop {
                max_pop = pop;
                max_year = 1950 + i as i32;
            }
        }
        max_year
    }
}