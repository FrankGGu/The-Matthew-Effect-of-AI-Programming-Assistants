impl Solution {
    pub fn rearrange_array(nums: Vec<i32>) -> Vec<i32> {
        let mut positives: Vec<i32> = Vec::new();
        let mut negatives: Vec<i32> = Vec::new();

        for num in nums {
            if num > 0 {
                positives.push(num);
            } else {
                negatives.push(num);
            }
        }

        let mut result: Vec<i32> = Vec::new();
        for i in 0..positives.len() {
            result.push(positives[i]);
            result.push(negatives[i]);
        }

        result
    }
}