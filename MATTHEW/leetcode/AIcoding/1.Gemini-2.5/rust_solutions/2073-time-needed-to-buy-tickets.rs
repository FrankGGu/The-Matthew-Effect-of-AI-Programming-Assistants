impl Solution {
    pub fn time_needed_to_buy_tickets(tickets: Vec<i32>, k: i32) -> i32 {
        let n = tickets.len();
        let k_usize = k as usize;
        let target_tickets_count = tickets[k_usize];
        let mut total_time = 0;

        for i in 0..n {
            if i <= k_usize {
                // For people at or before position k, they will buy tickets
                // for as many rounds as person k needs, or until they run out of tickets.
                total_time += std::cmp::min(tickets[i], target_tickets_count);
            } else {
                // For people after position k, they will buy tickets
                // for one less round than person k needs, because person k
                // will finish buying their last ticket before these people get another turn
                // in that final round.
                total_time += std::cmp::min(tickets[i], target_tickets_count - 1);
            }
        }

        total_time
    }
}