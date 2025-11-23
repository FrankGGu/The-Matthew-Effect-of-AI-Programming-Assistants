impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn odd_even_jump(arr: Vec<i32>) -> Vec<i32> {
        let n = arr.len();
        let mut res = vec![0; n];
        let mut sorted = arr.clone();
        sorted.sort();

        let mut index_map = std::collections::HashMap::new();
        for (i, &val) in arr.iter().enumerate() {
            index_map.entry(val).or_insert(Vec::new()).push(i);
        }

        let mut next_greater = vec![0; n];
        let mut next_smaller = vec![0; n];

        for i in 0..n {
            let val = arr[i];
            let mut j = i + 1;
            while j < n && arr[j] < val {
                j += 1;
            }
            if j < n {
                next_greater[i] = j as i32;
            } else {
                next_greater[i] = -1;
            }

            j = i + 1;
            while j < n && arr[j] > val {
                j += 1;
            }
            if j < n {
                next_smaller[i] = j as i32;
            } else {
                next_smaller[i] = -1;
            }
        }

        let mut even = vec![false; n];
        let mut odd = vec![false; n];
        even[n - 1] = true;
        odd[n - 1] = true;

        for i in (0..n - 1).rev() {
            let next_even = next_greater[i];
            if next_even != -1 {
                even[i] = odd[next_even as usize];
            }

            let next_odd = next_smaller[i];
            if next_odd != -1 {
                odd[i] = even[next_odd as usize];
            }
        }

        for i in 0..n {
            if odd[i] {
                res[i] = 1;
            }
        }

        res
    }
}
}