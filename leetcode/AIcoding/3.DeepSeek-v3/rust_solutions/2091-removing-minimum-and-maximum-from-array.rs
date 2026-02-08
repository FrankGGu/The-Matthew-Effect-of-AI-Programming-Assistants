impl Solution {
    pub fn minimum_deletions(nums: Vec<i32>) -> i32 {
        if nums.len() <= 2 {
            return nums.len() as i32;
        }

        let (min_pos, max_pos) = {
            let min_val = nums.iter().min().unwrap();
            let max_val = nums.iter().max().unwrap();
            let min_pos = nums.iter().position(|&x| x == *min_val).unwrap();
            let max_pos = nums.iter().position(|&x| x == *max_val).unwrap();
            if min_pos < max_pos {
                (min_pos, max_pos)
            } else {
                (max_pos, min_pos)
            }
        };

        let option1 = (max_pos + 1) as i32;
        let option2 = (nums.len() - min_pos) as i32;
        let option3 = (min_pos + 1 + nums.len() - max_pos) as i32;

        *[option1, option2, option3].iter().min().unwrap()
    }
}