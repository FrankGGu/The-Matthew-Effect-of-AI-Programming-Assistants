use std::collections::HashMap;

struct MajorityChecker {
    arr: Vec<i32>,
    count: HashMap<i32, Vec<usize>>,
}

impl MajorityChecker {
    fn new(arr: Vec<i32>) -> Self {
        let mut count = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            count.entry(num).or_insert(Vec::new()).push(i);
        }
        MajorityChecker { arr, count }
    }

    fn query(&self, left: i32, right: i32, threshold: i32) -> i32 {
        let left = left as usize;
        let right = right as usize;
        let len = right - left + 1;

        for _ in 0..20 {
            let idx = (rand::random::<f64>() * len as f64).floor() as usize + left;
            let num = self.arr[idx];

            if let Some(indices) = self.count.get(&num) {
                let mut l = 0;
                let mut r = indices.len();

                while l < r {
                    let mid = (l + r) / 2;
                    if indices[mid] < left {
                        l = mid + 1;
                    } else {
                        r = mid;
                    }
                }
                let left_idx = l;

                l = 0;
                r = indices.len();
                while l < r {
                    let mid = (l + r) / 2;
                    if indices[mid] <= right {
                        l = mid + 1;
                    } else {
                        r = mid;
                    }
                }
                let right_idx = l;

                if right_idx - left_idx >= threshold as usize {
                    return num;
                }
            }
        }
        -1
    }
}