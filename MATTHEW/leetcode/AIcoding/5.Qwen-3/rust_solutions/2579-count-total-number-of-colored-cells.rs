impl Solution {

use std::io;
use std::io::Read;

struct Solution {}

impl Solution {
    pub fn count_total_colored_cells(n: i32) -> i64 {
        let n = n as i64;
        (n * n + 1).abs()
    }
}

fn main() {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input).unwrap();
    let n: i32 = input.trim().parse().unwrap();
    println!("{}", Solution::count_total_colored_cells(n));
}
}