use std::collections::HashMap;

struct FindSumPairs {
    nums1: Vec<i32>,
    nums2: Vec<i32>,
    freq: HashMap<i32, i32>,
}

impl FindSumPairs {
    fn new(nums1: Vec<i32>, nums2: Vec<i32>) -> Self {
        let mut freq = HashMap::new();
        for &num in &nums2 {
            *freq.entry(num).or_insert(0) += 1;
        }
        FindSumPairs { nums1, nums2, freq }
    }

    fn add(&mut self, index: i32, val: i32) {
        let index = index as usize;
        let old_val = self.nums2[index];
        *self.freq.entry(old_val).or_insert(0) -= 1;
        self.nums2[index] += val;
        let new_val = self.nums2[index];
        *self.freq.entry(new_val).or_insert(0) += 1;
    }

    fn count(&self, tot: i32) -> i32 {
        let mut res = 0;
        for &num in &self.nums1 {
            let complement = tot - num;
            res += *self.freq.get(&complement).unwrap_or(&0);
        }
        res
    }
}