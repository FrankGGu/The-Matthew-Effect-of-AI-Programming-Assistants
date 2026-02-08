use std::collections::BTreeMap;

pub fn create_sorted_array(instructions: Vec<i32>) -> i32 {
    let mut count = BTreeMap::new();
    let mut res = 0;
    let mut total = 0;
    let mod_val = 1_000_000_007;

    for &x in &instructions {
        let left = count.range(..x).count() as i32;
        let right = count.range(x..).count() as i32;
        res = (res + left.min(right)) % mod_val;

        *count.entry(x).or_insert(0) += 1;
        total += 1;
    }

    res
}