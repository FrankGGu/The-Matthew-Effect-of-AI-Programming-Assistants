impl Solution {
    pub fn max_coins(bags: Vec<i32>, k: i32) -> i32 {
        let n = bags.len();
        let k_usize = k as usize;

        if k_usize == 0 || n < k_usize {
            return 0;
        }

        let mut current_sum: i32 = bags[0..k_usize].iter().sum();
        let mut max_coins = current_sum;

        for i in k_usize..n {
            current_sum = current_sum - bags[i - k_usize] + bags[i];
            max_coins = max_coins.max(current_sum);
        }

        max_coins
    }
}