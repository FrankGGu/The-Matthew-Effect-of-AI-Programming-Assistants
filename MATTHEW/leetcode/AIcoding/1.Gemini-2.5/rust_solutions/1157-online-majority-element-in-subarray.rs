use std::collections::HashMap;
use rand::Rng;
use rand::thread_rng;

struct MajorityChecker {
    arr: Vec<i32>,
    indices: HashMap<i32, Vec<usize>>,
    rng: rand::rngs::ThreadRng,
}

impl MajorityChecker {
    fn new(arr: Vec<i32>) -> Self {
        let mut indices: HashMap<i32, Vec<usize>> = HashMap::new();
        for (i, &val) in arr.iter().enumerate() {
            indices.entry(val).or_insert_with(Vec::new).push(i);
        }

        MajorityChecker {
            arr,
            indices,
            rng: thread_rng(),
        }
    }

    fn lower_bound(vec: &[usize], target: usize) -> usize {
        vec.binary_search(&target).unwrap_or_else(|i| i)
    }

    fn upper_bound(vec: &[usize], target: usize) -> usize {
        let mut low = 0;
        let mut high = vec.len();
        while low < high {
            let mid = low + (high - low) / 2;
            if vec[mid] <= target {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        low
    }

    fn query(&mut self, left: i32, right: i32, threshold: i32) -> i32 {
        let left_usize = left as usize;
        let right_usize = right as usize;

        const K_ATTEMPTS: usize = 20; 

        for _ in 0..K_ATTEMPTS {
            let random_idx = self.rng.gen_range(left_usize..=right_usize);
            let candidate = self.arr[random_idx];

            if let Some(indices_list) = self.indices.get(&candidate) {
                let count = Self::upper_bound(indices_list, right_usize) - Self::lower_bound(indices_list, left_usize);
                if count >= threshold as usize {
                    return candidate;
                }
            }
        }

        -1
    }
}