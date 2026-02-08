impl Solution {
    pub fn maximum_product(nums: Vec<i32>, k: i32) -> i32 {
        use std::collections::BinaryHeap;

        let mut max_heap = BinaryHeap::from(nums);
        let mut k = k;

        while k > 0 {
            if let Some(mut max_num) = max_heap.pop() {
                max_num += 1;
                max_heap.push(max_num);
                k -= 1;
            }
        }

        let mut product = 1;
        const MOD: i32 = 1_000_000_007;

        while let Some(num) = max_heap.pop() {
            product = (product * num) % MOD;
        }

        product
    }
}