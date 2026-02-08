impl Solution {
    pub fn summary_ranges(nums: Vec<i32>) -> Vec<String> {
        let mut res = Vec::new();
        if nums.is_empty() {
            return res;
        }
        let mut start = nums[0];
        let mut prev = nums[0];
        for &num in nums.iter().skip(1) {
            if num != prev + 1 {
                if start == prev {
                    res.push(format!("{}", start));
                } else {
                    res.push(format!("{}->{}", start, prev));
                }
                start = num;
            }
            prev = num;
        }
        if start == prev {
            res.push(format!("{}", start));
        } else {
            res.push(format!("{}->{}", start, prev));
        }
        res
    }
}