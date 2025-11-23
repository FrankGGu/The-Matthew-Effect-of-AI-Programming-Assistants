impl Solution {
    pub fn maximum_score(a: i32, b: i32, c: i32) -> i32 {
        let mut stones = vec![a, b, c];
        stones.sort();
        let mut score = 0;

        while stones[1] > 0 {
            score += 1;
            stones[1] -= 1;
            stones[2] -= 1;
            stones.sort();
        }

        score
    }
}