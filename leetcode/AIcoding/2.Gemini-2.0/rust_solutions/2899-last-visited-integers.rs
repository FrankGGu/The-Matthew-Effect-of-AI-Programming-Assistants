impl Solution {
    pub fn last_visited_integers(words: Vec<String>) -> Vec<i32> {
        let mut nums: Vec<i32> = Vec::new();
        let mut ans: Vec<i32> = Vec::new();
        let mut k = 0;

        for word in words {
            if word == "prev" {
                k += 1;
                if nums.len() as i32 - k >= 0 {
                    ans.push(nums[nums.len() - k as usize]);
                } else {
                    ans.push(-1);
                }
            } else {
                k = 0;
                nums.push(word.parse::<i32>().unwrap());
            }
        }

        ans
    }
}