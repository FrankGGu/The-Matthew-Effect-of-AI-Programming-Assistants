impl Solution {
    pub fn beautiful_subsets(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();

        for i in 1..(1 << n) {
            let mut subset = Vec::new();
            for j in 0..n {
                if (i >> j) & 1 == 1 {
                    subset.push(nums[j]);
                }
            }

            let mut beautiful = true;
            for x in 0..subset.len() {
                for y in x + 1..subset.len() {
                    if (subset[x] - subset[y]).abs() == k {
                        beautiful = false;
                        break;
                    }
                }
                if !beautiful {
                    break;
                }
            }

            if beautiful {
                count += 1;
            }
        }

        count
    }
}