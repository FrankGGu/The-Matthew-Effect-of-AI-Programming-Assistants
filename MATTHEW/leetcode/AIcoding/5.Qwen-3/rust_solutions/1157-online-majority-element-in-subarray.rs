impl Solution {

use std::collections::HashMap;

struct MajorityChecker {
    nums: Vec<i32>,
    index_map: HashMap<i32, Vec<usize>>,
}

impl MajorityChecker {
    fn new(nums: Vec<i32>) -> Self {
        let mut index_map = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            index_map.entry(num).or_insert_with(Vec::new).push(i);
        }
        MajorityChecker { nums, index_map }
    }

    fn query(&self, left: i32, right: i32, threshold: i32) -> i32 {
        let left = left as usize;
        let right = right as usize;
        let mut candidate = -1;
        let mut count = 0;

        for _ in 0..30 {
            let idx = left + (rand::random::<usize>() % (right - left + 1));
            let num = self.nums[idx];
            let indices = self.index_map.get(&num).unwrap();
            let freq = upper_bound(indices, right) - lower_bound(indices, left);
            if freq > threshold as usize {
                return num;
            }
        }

        -1
    }
}

fn lower_bound(arr: &Vec<usize>, target: usize) -> usize {
    let mut l = 0;
    let mut r = arr.len();
    while l < r {
        let m = (l + r) / 2;
        if arr[m] < target {
            l = m + 1;
        } else {
            r = m;
        }
    }
    l
}

fn upper_bound(arr: &Vec<usize>, target: usize) -> usize {
    let mut l = 0;
    let mut r = arr.len();
    while l < r {
        let m = (l + r) / 2;
        if arr[m] <= target {
            l = m + 1;
        } else {
            r = m;
        }
    }
    l
}
}