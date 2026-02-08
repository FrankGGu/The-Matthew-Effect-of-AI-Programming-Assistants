pub fn subarray_bitwise_ors(arr: Vec<i32>) -> i32 {
    let mut res = std::collections::HashSet::new();
    let mut current = 0;

    for &num in arr.iter().rev() {
        current |= num;
        res.insert(current);
        for &x in res.iter().collect::<Vec<_>>().iter() {
            res.insert(x | num);
        }
    }

    res.len() as i32
}