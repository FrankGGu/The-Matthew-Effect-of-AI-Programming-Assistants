impl Solution {
    pub fn maximize_happiness(mut happiness: Vec<i32>, k: i32) -> i64 {
        happiness.sort_unstable_by(|a, b| b.cmp(a));

        let mut total_happiness: i64 = 0;
        let k_usize = k as usize;

        for i in 0..k_usize {
            let current_happiness = happiness[i];
            let reduction = i as i32;

            let effective_happiness = current_happiness - reduction;

            total_happiness += (effective_happiness.max(0)) as i64;
        }

        total_happiness
    }
}