impl Solution {
    pub fn construct_array(n: i32, k: i32) -> Vec<i32> {
        let mut result = vec![0; n as usize];
        let mut current = k;
        for i in 0..(k as usize) {
            result[i] = current;
            current -= 1;
        }

        current = 1;
        for i in (k as usize)..(n as usize) {
            result[i] = current;
            current += 1;
        }

        result
    }
}