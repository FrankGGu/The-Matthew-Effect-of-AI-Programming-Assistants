impl Solution {
    pub fn can_choose(groups: Vec<Vec<i32>>, nums: Vec<i32>) -> bool {
        let mut i = 0;
        let n = nums.len();

        for group in groups {
            let m = group.len();
            let mut found = false;

            while i + m <= n {
                if nums[i..i + m] == group[..] {
                    found = true;
                    i += m;
                    break;
                }
                i += 1;
            }

            if !found {
                return false;
            }
        }

        true
    }
}