use std::collections::HashMap;

struct Solution {
    map: HashMap<i32, Vec<usize>>,
}

impl Solution {
    fn new(nums: Vec<i32>) -> Self {
        let mut map = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            map.entry(num).or_insert(Vec::new()).push(i);
        }
        Solution { map }
    }

    fn pick(&self, target: i32) -> i32 {
        let indices = self.map.get(&target).unwrap();
        let idx = fastrand::usize(..indices.len());
        indices[idx] as i32
    }
}