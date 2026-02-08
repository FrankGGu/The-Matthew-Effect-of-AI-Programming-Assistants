impl Solution {
    pub fn find_occurrences(arr: Vec<i32>, target: i32) -> i32 {
        arr.iter().filter(|&&x| x == target).count() as i32
    }
}