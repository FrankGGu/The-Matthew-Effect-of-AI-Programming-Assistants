impl Solution {
    pub fn can_partition(nums: Vec<i32>) -> bool {
        let product: i64 = nums.iter().map(|&x| x as i64).product();

        if product == 0 {
            return nums.contains(&0);
        }

        let n = nums.len();
        for i in 0..(1 << n) {
            let mut product1: i64 = 1;
            let mut product2: i64 = 1;

            for j in 0..n {
                if (i >> j) & 1 == 1 {
                    if nums[j] == 0 {
                        product1 = 0;
                    } else {
                        product1 *= nums[j] as i64;
                    }
                } else {
                    if nums[j] == 0 {
                        product2 = 0;
                    } else {
                        product2 *= nums[j] as i64;
                    }
                }
            }

            if product1 == product2 {
                return true;
            }
        }

        false
    }
}