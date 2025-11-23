impl Solution {
    pub fn max_div_score(nums: Vec<i32>, divisors: Vec<i32>) -> i32 {
        let mut max_score = 0;
        let mut result = 0;

        for &div in &divisors {
            let score: i32 = nums.iter().filter(|&&num| num % div == 0).count() as i32;
            if score > max_score || (score == max_score && div < result) {
                max_score = score;
                result = div;
            }
        }

        result
    }
}