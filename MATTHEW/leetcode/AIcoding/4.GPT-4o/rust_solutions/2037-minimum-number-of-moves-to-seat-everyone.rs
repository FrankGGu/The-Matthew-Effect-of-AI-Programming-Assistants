impl Solution {
    pub fn min_moves_to_seat(seats: Vec<i32>, students: Vec<i32>) -> i32 {
        let mut seats = seats;
        let mut students = students;
        seats.sort();
        students.sort();
        seats.iter().zip(students.iter()).map(|(s, st)| (s - st).abs()).sum()
    }
}