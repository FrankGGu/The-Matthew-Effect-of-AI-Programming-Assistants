impl Solution {
    pub fn rearrange_array(nums: Vec<i32>) -> Vec<i32> {
        let mut pos: Vec<i32> = Vec::new();
        let mut neg: Vec<i32> = Vec::new();

        for &num in &nums {
            if num > 0 {
                pos.push(num);
            } else {
                neg.push(num);
            }
        }

        let mut result: Vec<i32> = Vec::new();
        let mut i = 0;
        let mut j = 0;

        while i < pos.len() && j < neg.len() {
            result.push(pos[i]);
            result.push(neg[j]);
            i += 1;
            j += 1;
        }

        result
    }
}