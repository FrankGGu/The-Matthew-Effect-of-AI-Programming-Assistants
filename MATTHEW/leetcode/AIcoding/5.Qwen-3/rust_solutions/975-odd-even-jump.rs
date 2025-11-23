impl Solution {

use std::collections::BTreeSet;

impl Solution {
    pub fn odd_even_jumps(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut sorted = arr.clone();
        sorted.sort();

        let mut index_map = std::collections::HashMap::new();
        for (i, &val) in arr.iter().enumerate() {
            index_map.entry(val).or_insert(Vec::new()).push(i);
        }

        let mut next_higher = vec![0; n];
        let mut next_lower = vec![0; n];

        for (i, &val) in arr.iter().enumerate() {
            let higher = index_map.get(&val).unwrap();
            let mut j = higher.binary_search(&i).unwrap();
            while j + 1 < higher.len() && higher[j + 1] == i {
                j += 1;
            }
            if j + 1 < higher.len() {
                next_higher[i] = higher[j + 1];
            } else {
                next_higher[i] = n;
            }

            j = higher.binary_search(&i).unwrap();
            while j > 0 && higher[j - 1] == i {
                j -= 1;
            }
            if j > 0 {
                next_lower[i] = higher[j - 1];
            } else {
                next_lower[i] = n;
            }
        }

        let mut odd = vec![false; n];
        let mut even = vec![false; n];
        odd[n - 1] = true;
        even[n - 1] = true;

        for i in (0..n - 1).rev() {
            let higher_index = next_higher[i];
            if higher_index < n {
                odd[i] = even[higher_index];
            }

            let lower_index = next_lower[i];
            if lower_index < n {
                even[i] = odd[lower_index];
            }
        }

        odd.iter().filter(|&&b| b).count() as i32
    }
}
}