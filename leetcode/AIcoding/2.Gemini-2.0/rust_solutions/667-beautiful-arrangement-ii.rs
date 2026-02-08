impl Solution {
    pub fn construct_array(n: i32, k: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut left = 1;
        let mut right = k + 1;
        let mut flag = true;
        while left <= right {
            if flag {
                result.push(left);
                left += 1;
            } else {
                result.push(right);
                right -= 1;
            }
            flag = !flag;
        }
        for i in k + 2..=n {
            result.push(i);
        }
        result
    }
}