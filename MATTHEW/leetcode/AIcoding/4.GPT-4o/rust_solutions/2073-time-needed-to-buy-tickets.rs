impl Solution {
    pub fn time_needed_to_buy(tickets: Vec<i32>, k: i32) -> i32 {
        let mut time = 0;
        let target = tickets[k as usize];

        for (i, &ticket) in tickets.iter().enumerate() {
            if ticket > target {
                time += target;
            } else if i as i32 <= k {
                time += ticket;
            } else {
                time += ticket.min(target);
            }
        }
        time
    }
}