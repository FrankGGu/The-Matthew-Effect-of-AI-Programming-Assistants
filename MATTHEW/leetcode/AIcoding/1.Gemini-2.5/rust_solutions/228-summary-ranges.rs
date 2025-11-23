impl Solution {
    pub fn summary_ranges(nums: Vec<i32>) -> Vec<String> {
        if nums.is_empty() {
            return Vec::new();
        }

        let mut result: Vec<String> = Vec::new();
        let n = nums.len();
        let mut i = 0;

        while i < n {
            let start = nums[i];
            let mut j = i + 1;

            while j < n && nums[j] == nums[j - 1] + 1 {
                j += 1;
            }

            let end = nums[j - 1];

            if start == end {
                result.push(start.to_string());
            } else {
                result.push(format!("{}->{}", start, end));
            }

            i = j;
        }

        result
    }
}