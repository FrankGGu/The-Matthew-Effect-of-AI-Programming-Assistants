use std::collections::BTreeMap;

impl Solution {
    pub fn odd_even_jumps(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n <= 1 {
            return n as i32;
        }

        let mut dp_odd = vec![false; n];
        let mut dp_even = vec![false; n];

        dp_odd[n - 1] = true;
        dp_even[n - 1] = true;

        let mut map: BTreeMap<i32, usize> = BTreeMap::new();
        map.insert(arr[n - 1], n - 1);

        let mut good_starts = 1;

        for i in (0..n - 1).rev() {
            let current_val = arr[i];

            let next_odd_idx = map.range(current_val..)
                                  .next()
                                  .map(|(_, &idx)| idx);

            let next_even_idx = map.range(..=current_val)
                                   .rev()
                                   .next()
                                   .map(|(_, &idx)| idx);

            if let Some(j) = next_odd_idx {
                dp_odd[i] = dp_even[j];
            }
            if let Some(j) = next_even_idx {
                dp_even[i] = dp_odd[j];
            }

            if dp_odd[i] {
                good_starts += 1;
            }

            map.insert(current_val, i);
        }

        good_starts
    }
}