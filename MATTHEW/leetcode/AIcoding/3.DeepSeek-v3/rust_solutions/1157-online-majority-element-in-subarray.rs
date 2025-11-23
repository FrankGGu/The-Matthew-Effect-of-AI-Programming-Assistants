use std::collections::HashMap;

struct MajorityChecker {
    map: HashMap<i32, Vec<usize>>,
    arr: Vec<i32>,
}

impl MajorityChecker {
    fn new(arr: Vec<i32>) -> Self {
        let mut map = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            map.entry(num).or_insert(Vec::new()).push(i);
        }
        MajorityChecker { map, arr }
    }

    fn query(&self, left: i32, right: i32, threshold: i32) -> i32 {
        let left = left as usize;
        let right = right as usize;
        for _ in 0..20 {
            let idx = rand::random::<usize>() % (right - left + 1) + left;
            let num = self.arr[idx];
            let indices = &self.map[&num];
            let l = indices.binary_search(&left).unwrap_or_else(|x| x);
            let r = indices.binary_search(&(right + 1)).unwrap_or_else(|x| x);
            if r - l >= threshold as usize {
                return num;
            }
        }
        -1
    }
}