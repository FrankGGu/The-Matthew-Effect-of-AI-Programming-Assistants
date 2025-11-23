struct Solution;

impl Solution {
    pub fn find_solution(custom_function: CustomFunction, z: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut x = 1;
        let mut y = 1000;

        while x <= 1000 && y >= 1 {
            let val = custom_function.call(x, y);
            if val == z {
                result.push(vec![x, y]);
                x += 1;
                y -= 1;
            } else if val < z {
                x += 1;
            } else { // val > z
                y -= 1;
            }
        }
        result
    }
}