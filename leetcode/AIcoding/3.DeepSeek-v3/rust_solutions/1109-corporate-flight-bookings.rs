impl Solution {
    pub fn corp_flight_bookings(bookings: Vec<Vec<i32>>, n: i32) -> Vec<i32> {
        let mut res = vec![0; n as usize];
        for booking in bookings {
            let first = booking[0] as usize - 1;
            let last = booking[1] as usize - 1;
            let seats = booking[2];
            res[first] += seats;
            if last + 1 < n as usize {
                res[last + 1] -= seats;
            }
        }
        for i in 1..n as usize {
            res[i] += res[i - 1];
        }
        res
    }
}