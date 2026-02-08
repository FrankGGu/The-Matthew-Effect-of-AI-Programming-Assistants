use std::collections::HashMap;

struct FindSumPairs {
    nums1: Vec<i32>,
    nums2: Vec<i32>,
    count: HashMap<i32, i32>,
}

impl FindSumPairs {
    fn new(nums1: Vec<i32>, nums2: Vec<i32>) -> Self {
        let mut count: HashMap<i32, i32> = HashMap::new();
        for &num in &nums2 {
            *count.entry(num).or_insert(0) += 1;
        }
        FindSumPairs {
            nums1,
            nums2,
            count,
        }
    }

    fn add(&mut self, index: i32, val: i32) {
        let index = index as usize;
        let old_val = self.nums2[index];
        *self.count.entry(old_val).or_insert(0) -= 1;
        if self.count[&old_val] == 0 {
            self.count.remove(&old_val);
        }
        self.nums2[index] += val;
        *self.count.entry(self.nums2[index]).or_insert(0) += 1;
    }

    fn count(&self, tot: i32) -> i32 {
        let mut res = 0;
        for &num in &self.nums1 {
            if self.count.contains_key(&(tot - num)) {
                res += self.count[&(tot - num)];
            }
        }
        res
    }
}