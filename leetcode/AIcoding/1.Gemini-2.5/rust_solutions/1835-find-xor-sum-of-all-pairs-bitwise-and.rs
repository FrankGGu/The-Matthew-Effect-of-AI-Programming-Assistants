impl Solution {
    pub fn xor_sum_of_all_pairs_bitwise_and(arr1: Vec<i32>, arr2: Vec<i32>) -> i32 {
        let xor_sum1 = arr1.iter().fold(0, |acc, &x| acc ^ x);
        let xor_sum2 = arr2.iter().fold(0, |acc, &x| acc ^ x);
        xor_sum1 & xor_sum2
    }
}