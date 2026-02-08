struct Solution;

impl Solution {
    static mut COMBINATIONS: [[u64; 49]; 49] = [[0; 49]; 49];
    static mut INITIALIZED: bool = false;

    fn init_combinations() {
        unsafe {
            if Solution::INITIALIZED {
                return;
            }
            for i in 0..49 {
                Solution::COMBINATIONS[i][0] = 1;
                for j in 1..=i {
                    Solution::COMBINATIONS[i][j] = Solution::COMBINATIONS[i - 1][j - 1] + Solution::COMBINATIONS[i - 1][j];
                }
            }
            Solution::INITIALIZED = true;
        }
    }

    fn get_combinations(n: usize, k: usize) -> u64 {
        unsafe {
            Solution::COMBINATIONS[n][k]
        }
    }

    pub fn get_probability(colors: Vec<i32>) -> f64 {
        Solution::init_combinations();

        let k = colors.len();
        let total_balls: i32 = colors.iter().sum();
        let target_balls_per_box = total_balls / 2;

        let mut favorable_permutations: u128 = 0;
        let mut total_permutations: u128 = 0;

        let mut stack: Vec<(usize, i32, i32, i32, i32, u128)> = Vec::new();
        stack.push((0, 0, 0, 0, 0, 1)); // (color_idx, balls_box1, distinct_box1, balls_box2, distinct_box2, current_ways)

        while let Some((
            color_idx,
            balls_box1,
            distinct_box1,
            balls_box2,
            distinct_box2,
            current_ways,
        )) = stack.pop() {

            if color_idx == k {
                if balls_box1 == target_balls_per_box && balls_box2 == target_balls_per_box {
                    total_permutations += current_ways;
                    if distinct_box1 == distinct_box2 {
                        favorable_permutations += current_ways;
                    }
                }
                continue;
            }

            let num_balls_of_current_color = colors[color_idx];

            for j in 0..=num_balls_of_current_color {
                let new_balls_box1 = balls_box1 + j;
                let new_balls_box2 = balls_box2 + (num_balls_of_current_color - j);

                if new_balls_box1 > target_balls_per_box || new_balls_box2 > target_balls_per_box {
                    continue;
                }

                let new_distinct_box1 = distinct_box1 + if j > 0 { 1 } else { 0 };
                let new_distinct_box2 = distinct_box2 + if (num_balls_of_current_color - j) > 0 { 1 } else { 0 };

                let ways_for_this_color = Solution::get_combinations(num_balls_of_current_color as usize, j as usize) as u128;
                let new_current_ways = current_ways * ways_for_this_color;

                stack.push((
                    color_idx + 1,
                    new_balls_box1,
                    new_distinct_box1,
                    new_balls_box2,
                    new_distinct_box2,
                    new_current_ways,
                ));
            }
        }

        if total_permutations == 0 {
            0.0
        } else {
            favorable_permutations as f64 / total_permutations as f64
        }
    }
}