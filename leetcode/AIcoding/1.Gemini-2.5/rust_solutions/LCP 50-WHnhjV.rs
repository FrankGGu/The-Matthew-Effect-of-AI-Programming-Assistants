impl Solution {
    pub fn jewel_supply(mut jewels: Vec<i32>, k: i32) -> Vec<i32> {
        for _ in 0..k {
            let mut max_idx = 0;
            let mut min_idx = 0;
            let mut max_val = jewels[0];
            let mut min_val = jewels[0];

            for i in 1..jewels.len() {
                if jewels[i] > max_val {
                    max_val = jewels[i];
                    max_idx = i;
                }
                if jewels[i] < min_val {
                    min_val = jewels[i];
                    min_idx = i;
                }
            }

            let transfer_amount = jewels[max_idx] / 2;
            jewels[max_idx] -= transfer_amount;
            jewels[min_idx] += transfer_amount;
        }
        jewels
    }
}