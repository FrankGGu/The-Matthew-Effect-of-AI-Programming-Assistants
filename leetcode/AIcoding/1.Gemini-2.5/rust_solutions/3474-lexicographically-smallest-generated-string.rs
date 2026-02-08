impl Solution {
    pub fn get_smallest_string(n: i32) -> String {
        let mut result = String::with_capacity(n as usize);
        let chars = ['a', 'b', 'c'];

        for i in 0..(n as usize) {
            result.push(chars[i % 3]);
        }

        result
    }
}