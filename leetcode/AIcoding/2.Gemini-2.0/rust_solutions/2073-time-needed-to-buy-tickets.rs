impl Solution {
    pub fn time_needed_to_buy(tickets: Vec<i32>, k: i32) -> i32 {
        let mut time = 0;
        let k_usize = k as usize;
        let mut tickets_copy = tickets.clone();

        while tickets_copy[k_usize] > 0 {
            for i in 0..tickets_copy.len() {
                if tickets_copy[i] > 0 {
                    tickets_copy[i] -= 1;
                    time += 1;
                }
                if tickets_copy[k_usize] == 0 {
                    break;
                }
            }
        }

        time
    }
}