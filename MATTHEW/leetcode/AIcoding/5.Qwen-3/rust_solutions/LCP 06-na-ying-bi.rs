struct Solution;

impl Solution {
    pub fn count_coins(mut seats: Vec<i32>, mut students: Vec<i32>) -> i32 {
        seats.sort();
        students.sort();
        let mut res = 0;
        for i in 0..seats.len() {
            res += (seats[i] - students[i]).abs();
        }
        res
    }
}