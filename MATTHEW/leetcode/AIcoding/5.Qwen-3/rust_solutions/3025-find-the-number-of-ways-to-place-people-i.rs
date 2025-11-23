impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn number_of_ways(people: Vec<Vec<i32>>) -> i32 {
        let mut x_coords: Vec<i32> = people.iter().map(|p| p[0]).collect();
        let mut y_coords: Vec<i32> = people.iter().map(|p| p[1]).collect();

        x_coords.sort();
        y_coords.sort();

        let mut x_count = HashMap::new();
        for &x in &x_coords {
            *x_count.entry(x).or_insert(0) += 1;
        }

        let mut y_count = HashMap::new();
        for &y in &y_coords {
            *y_count.entry(y).or_insert(0) += 1;
        }

        let mut res = 0;
        for i in 0..people.len() {
            let x = people[i][0];
            let y = people[i][1];

            let x_left = x_count.get(&x).unwrap();
            let x_right = (people.len() as i32 - *x_left);

            let y_left = y_count.get(&y).unwrap();
            let y_right = (people.len() as i32 - *y_left);

            res += x_left * x_right * y_left * y_right;
        }

        res
    }
}
}