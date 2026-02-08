impl Solution {
    pub fn get_probability(balls: Vec<i32>) -> f64 {
        let total_balls: i32 = balls.iter().sum();
        let half_balls = total_balls / 2;
        let mut count = 0.0;
        let mut total = 0.0;
        let n = balls.len();

        fn combinations(n: i32, k: i32) -> f64 {
            if k < 0 || k > n {
                return 0.0;
            }
            if k == 0 || k == n {
                return 1.0;
            }
            if k > n / 2 {
                return combinations(n, n - k);
            }
            let mut res = 1.0;
            for i in 1..=k {
                res = res * (n as f64 - i as f64 + 1.0) / i as f64;
            }
            res
        }

        fn backtrack(
            balls: &Vec<i32>,
            index: usize,
            box1_balls: i32,
            box1_distinct: i32,
            box2_distinct: i32,
            mut box1: Vec<i32>,
            mut box2: Vec<i32>,
            half_balls: i32,
            count: &mut f64,
            total: &mut f64,
        ) {
            if index == balls.len() {
                if box1_balls == half_balls {
                    *total += 1.0;
                    if box1_distinct == box2_distinct {
                        *count += 1.0;
                    }
                }
                return;
            }

            for i in 0..=balls[index] {
                if box1_balls + i <= half_balls {
                    let mut new_box1 = box1.clone();
                    let mut new_box2 = box2.clone();

                    new_box1.push(i);
                    new_box2.push(balls[index] - i);

                    let new_box1_distinct = if i > 0 {
                        box1_distinct + 1
                    } else {
                        box1_distinct
                    };

                    let new_box2_distinct = if balls[index] - i > 0 {
                        box2_distinct + 1
                    } else {
                        box2_distinct
                    };

                    backtrack(
                        balls,
                        index + 1,
                        box1_balls + i,
                        new_box1_distinct,
                        new_box2_distinct,
                        new_box1,
                        new_box2,
                        half_balls,
                        count,
                        total,
                    );
                }
            }
        }

        let mut box1 = Vec::new();
        let mut box2 = Vec::new();
        backtrack(
            &balls,
            0,
            0,
            0,
            0,
            box1,
            box2,
            half_balls,
            &mut count,
            &mut total,
        );

        let mut total_ways = 1.0;
        let mut good_ways = 0.0;

        fn backtrack_count(
            balls: &Vec<i32>,
            index: usize,
            box1_balls: i32,
            mut box1_counts: Vec<i32>,
            half_balls: i32,
            total_ways: &mut f64,
            good_ways: &mut f64
        ){
            if index == balls.len(){
                if box1_balls == half_balls{
                    let mut temp_total_ways = 1.0;
                    for i in 0..balls.len(){
                        temp_total_ways *= combinations(balls[i], box1_counts[i]);
                    }
                    *total_ways += temp_total_ways;

                    let mut box2_counts = Vec::new();
                    for i in 0..balls.len(){
                        box2_counts.push(balls[i] - box1_counts[i]);
                    }

                    let box1_distinct = box1_counts.iter().filter(|&x| *x > 0).count();
                    let box2_distinct = box2_counts.iter().filter(|&x| *x > 0).count();

                    if box1_distinct == box2_distinct{
                         *good_ways += temp_total_ways;
                    }
                }
                return;
            }

            for i in 0..=balls[index]{
                if box1_balls + i <= half_balls{
                    let mut new_box1_counts = box1_counts.clone();
                    new_box1_counts.push(i);

                    backtrack_count(balls, index + 1, box1_balls + i, new_box1_counts, half_balls, total_ways, good_ways);
                }
            }
        }

        let mut box1_counts = Vec::new();

        backtrack_count(&balls, 0, 0, box1_counts, half_balls, &mut total_ways, &mut good_ways);

        good_ways / total_ways
    }
}