pub fn corp_flight_bookings(bookings: Vec<Vec<i32>>, n: i32) -> Vec<i32> {
    let mut flights = vec![0; n as usize];
    let mut diff = vec![0; (n + 1) as usize];

    for booking in bookings {
        let (start, end, seats) = (booking[0], booking[1], booking[2]);
        diff[start as usize - 1] += seats;
        if end as usize <= n as usize {
            diff[end as usize] -= seats;
        }
    }

    for i in 1..n as usize {
        diff[i] += diff[i - 1];
    }

    for i in 0..n as usize {
        flights[i] = diff[i];
    }

    flights
}