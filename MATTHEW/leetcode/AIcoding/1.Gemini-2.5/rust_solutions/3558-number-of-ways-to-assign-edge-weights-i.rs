impl Solution {
    pub fn number_of_ways_to_assign_edge_weights_i(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let m = edges.len();
        let modulo: i32 = 1_000_000_007;
        let mut result: i32 = 1;

        for i in 1..=m {
            result = (result as i64 * i as i64 % modulo as i64) as i32;
        }

        result
    }
}