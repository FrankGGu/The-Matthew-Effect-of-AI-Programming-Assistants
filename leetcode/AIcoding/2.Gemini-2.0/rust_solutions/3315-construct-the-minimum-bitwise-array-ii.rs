impl Solution {
    pub fn construct_array(n: i32, k: i32) -> Vec<i32> {
        let mut result = vec![0; n as usize];
        result[0] = 0;
        result[1] = k;

        let mut current = k + 1;
        for i in 2..n {
            result[i as usize] = current;
            current += 1;
        }

        result
    }
}