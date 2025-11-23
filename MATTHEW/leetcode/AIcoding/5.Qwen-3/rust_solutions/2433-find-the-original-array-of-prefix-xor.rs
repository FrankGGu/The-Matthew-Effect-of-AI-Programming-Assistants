impl Solution {

use std::vec;

impl Solution {
    pub fn find_original_array(encrypted: Vec<i32>) -> Vec<i32> {
        let n = encrypted.len();
        if n % 2 == 1 {
            return vec![];
        }
        let mut original = vec![0; n];
        original[0] = encrypted[0];
        for i in 1..n {
            original[i] = encrypted[i] ^ encrypted[i - 1];
        }
        original
    }
}
}