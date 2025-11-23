struct Solution;

impl Solution {
    pub fn get_maximum_xor(mut nums: Vec<i32>, mut queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut max_xor = 0;
        for num in &nums {
            max_xor ^= *num;
        }
        for query in &mut queries {
            query[1] ^= max_xor;
        }
        queries.into_iter().map(|q| q[1]).collect()
    }
}