use std::collections::BTreeMap;

impl Solution {
    pub fn get_subarray_beauty(nums: Vec<i32>, k: i32, x: i32) -> Vec<i32> {
        let k = k as usize;
        let x = x as usize;
        let mut result = Vec::new();
        let mut window = BTreeMap::new();

        for i in 0..nums.len() {
            if i >= k {
                let remove_num = nums[i - k];
                *window.entry(remove_num).or_insert(0) -= 1;
                if window[&remove_num] == 0 {
                    window.remove(&remove_num);
                }
            }

            *window.entry(nums[i]).or_insert(0) += 1;

            if i >= k - 1 {
                let mut count = 0;
                let mut beauty = 0;
                for (&num, &cnt) in window.iter() {
                    if num >= 0 {
                        break;
                    }
                    count += cnt;
                    if count >= x {
                        beauty = num;
                        break;
                    }
                }
                result.push(beauty);
            }
        }

        result
    }
}