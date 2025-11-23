impl Solution {
    pub fn is_covered(ranges: Vec<Vec<i3>>, left: i3, right: i3) -> bool {
        let mut covered_nums = vec![false; 51];

        for range in ranges {
            let start = range[0];
            let end = range[1];
            for i in start..=end {
                covered_nums[i as usize] = true;
            }
        }

        for i in left..=right {
            if !covered_nums[i as usize] {
                return false;
            }
        }

        true
    }
}