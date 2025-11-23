pub fn max_strength(nums: Vec<i32>, k: i32) -> i32 {
    let n = nums.len();
    let k = k as usize;

    let mut max_strength = std::i32::MIN;

    for i in 0..(1 << n) {
        let mut count = 0;
        let mut product = 1;
        let mut valid = true;

        for j in 0..n {
            if (i & (1 << j)) != 0 {
                count += 1;
                product *= nums[j];
                if product == 0 {
                    valid = false;
                }
            }
        }

        if valid && count == k {
            max_strength = max_strength.max(product);
        }
    }

    max_strength
}