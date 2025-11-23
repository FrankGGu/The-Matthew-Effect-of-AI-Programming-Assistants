impl Solution {
    pub fn odd_even_jump(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut odd_jumps = vec![false; n];
        let mut even_jumps = vec![false; n];
        odd_jumps[n - 1] = true;
        even_jumps[n - 1] = true;

        let mut tree_map = std::collections::BTreeMap::new();
        tree_map.insert(arr[n - 1], n - 1);

        for i in (0..n - 1).rev() {
            if let Some((&key, &val)) = tree_map.range(arr[i]..).next() {
                odd_jumps[i] = even_jumps[val];
            }

            if let Some((&key, &val)) = tree_map.range(..=arr[i]).rev().next() {
                even_jumps[i] = odd_jumps[val];
            }

            tree_map.insert(arr[i], i);
        }

        odd_jumps.iter().filter(|&x| *x).count() as i32
    }
}