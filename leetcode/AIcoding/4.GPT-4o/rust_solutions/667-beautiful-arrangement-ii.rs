impl Solution {
    pub fn construct_arrangement(n: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut left = 1;
        let mut right = n;

        while left <= right {
            if left == right {
                result.push(left);
            } else {
                result.push(left);
                result.push(right);
            }
            left += 1;
            right -= 1;
        }
        result
    }
}