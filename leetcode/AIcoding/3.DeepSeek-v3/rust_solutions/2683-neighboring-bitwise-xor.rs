impl Solution {
    pub fn does_valid_array_exist(derived: Vec<i32>) -> bool {
        let mut original = vec![0; derived.len()];
        for i in 1..derived.len() {
            original[i] = original[i - 1] ^ derived[i - 1];
        }
        (original[0] ^ original[original.len() - 1]) == derived[derived.len() - 1]
    }
}