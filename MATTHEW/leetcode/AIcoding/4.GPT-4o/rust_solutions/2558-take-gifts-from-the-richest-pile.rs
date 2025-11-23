impl Solution {
    pub fn pick_gifts(gifts: Vec<i32>, k: i32) -> i32 {
        let mut gifts = gifts;
        let k = k as usize;
        for _ in 0..k {
            if let Some(max_idx) = gifts.iter().position(|&x| x == *gifts.iter().max().unwrap()) {
                gifts[max_idx] = (gifts[max_idx] as f64).sqrt() as i32;
            }
        }
        gifts.iter().sum()
    }
}