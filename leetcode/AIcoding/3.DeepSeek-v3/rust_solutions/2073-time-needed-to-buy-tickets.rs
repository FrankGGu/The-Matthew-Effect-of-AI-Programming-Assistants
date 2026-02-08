impl Solution {
    pub fn time_required_to_buy(tickets: Vec<i32>, k: i32) -> i32 {
        let mut time = 0;
        let k = k as usize;
        loop {
            for i in 0..tickets.len() {
                if tickets[i] > 0 {
                    time += 1;
                    if i == k && tickets[i] == 1 {
                        return time;
                    }
                }
            }
        }
    }
}