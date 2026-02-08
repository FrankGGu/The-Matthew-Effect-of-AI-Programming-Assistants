impl Solution {
    pub fn subsets(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = vec![vec![]];

        for num in nums {
            let current_len = result.len();
            for i in 0..current_len {
                let mut subset = result[i].clone();
                subset.push(num);
                result.push(subset);
            }
        }

        result
    }
}