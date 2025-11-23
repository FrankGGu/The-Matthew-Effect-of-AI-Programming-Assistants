impl Solution {
    pub fn pivot_array(nums: Vec<i32>, pivot: i32) -> Vec<i32> {
        let mut less = Vec::new();
        let mut equal = Vec::new();
        let mut greater = Vec::new();

        for &num in &nums {
            if num < pivot {
                less.push(num);
            } else if num == pivot {
                equal.push(num);
            } else {
                greater.push(num);
            }
        }

        less.extend(equal);
        less.extend(greater);

        less
    }
}