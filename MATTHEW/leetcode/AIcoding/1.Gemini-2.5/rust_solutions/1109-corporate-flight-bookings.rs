impl Solution {
    pub fn corp_flight_bookings(bookings: Vec<Vec<i32>>, n: i32) -> Vec<i32> {
        let n_usize = n as usize;
        let mut result = vec![0; n_usize];

        for booking in bookings {
            let first = booking[0] as usize - 1;
            let last = booking[1] as usize - 1;
            let seats = booking[2];

            result[first] += seats;
            if last + 1 < n_usize {
                result[last + 1] -= seats;
            }
        }

        for i in 1..n_usize {
            result[i] += result[i - 1];
        }

        result
    }
}