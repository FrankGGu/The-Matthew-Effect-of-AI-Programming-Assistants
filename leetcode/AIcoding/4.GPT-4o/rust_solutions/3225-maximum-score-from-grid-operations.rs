impl Solution {
    pub fn maximum_score(a: i32, b: i32, c: i32) -> i32 {
        let mut nums = vec![a, b, c];
        nums.sort();
        let (x, y, z) = (nums[0], nums[1], nums[2]);
        let mut score = 0;

        while y > 0 {
            score += 1;
            y -= 1;
            z -= 1;
            if z < 0 {
                break;
            }
            if y < 0 {
                break;
            }
        }

        score
    }
}