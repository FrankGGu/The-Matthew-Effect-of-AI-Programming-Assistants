impl Solution {
    pub fn last_visited_integers(words: Vec<String>) -> Vec<i32> {
        let mut nums = Vec::new();
        let mut result = Vec::new();
        let mut k = 0;

        for word in words {
            if word == "prev" {
                k += 1;
                if nums.len() >= k {
                    result.push(nums[nums.len() - k]);
                } else {
                    result.push(-1);
                }
            } else {
                k = 0;
                nums.push(word.parse::<i32>().unwrap());
            }
        }

        result
    }
}