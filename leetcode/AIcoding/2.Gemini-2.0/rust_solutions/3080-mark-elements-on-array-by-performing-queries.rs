impl Solution {
    pub fn mark_elements(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = nums.len();
        let mut marked = vec![false; n];
        let mut result = Vec::new();

        for query in queries {
            let type_ = query[0];
            if type_ == 1 {
                let index = query[1] as usize;
                if index > 0 && index <= n && !marked[index - 1] {
                    marked[index - 1] = true;
                }
            } else {
                let index = query[1] as usize;
                if index > 0 && index <= n {
                    result.push(marked[index - 1]);
                }
            }
        }

        result
    }
}