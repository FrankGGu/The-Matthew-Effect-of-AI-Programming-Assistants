use std::collections::HashMap;

struct MajorityChecker {
    arr: Vec<i32>,
    count: HashMap<i32, Vec<usize>>,
}

impl MajorityChecker {
    fn new(arr: Vec<i32>) -> Self {
        let mut count: HashMap<i32, Vec<usize>> = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            count.entry(num).or_insert(vec![]).push(i);
        }
        MajorityChecker { arr, count }
    }

    fn query(&self, left: i32, right: i32, threshold: i32) -> i32 {
        let left = left as usize;
        let right = right as usize;
        let mut candidate = -1;

        for (&num, indices) in &self.count {
            let start = indices.partition_point(|&x| x < left);
            let end = indices.partition_point(|&x| x <= right);
            let occurrences = end - start;

            if occurrences >= threshold {
                candidate = num;
                break;
            }
        }

        candidate
    }
}