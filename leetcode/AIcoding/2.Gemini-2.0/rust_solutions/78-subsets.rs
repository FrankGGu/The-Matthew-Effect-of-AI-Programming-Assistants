impl Solution {
    pub fn subsets(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = vec![vec![]];
        for &num in &nums {
            let mut new_subsets: Vec<Vec<i32>> = vec![];
            for subset in &result {
                let mut new_subset = subset.clone();
                new_subset.push(num);
                new_subsets.push(new_subset);
            }
            result.extend(new_subsets);
        }
        result
    }
}