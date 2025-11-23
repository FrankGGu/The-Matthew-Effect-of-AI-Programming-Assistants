pub fn min_sum_of_lengths(arr: Vec<i32>, target: i32) -> i32 {
    use std::collections::HashMap;

    let mut prefix_sum = HashMap::new();
    let mut sum = 0;
    let mut min_len = i32::MAX;
    let mut result = i32::MAX;

    prefix_sum.insert(0, -1);

    for (i, &num) in arr.iter().enumerate() {
        sum += num;
        if let Some(&start) = prefix_sum.get(&(sum - target)) {
            min_len = min_len.min((i - start) as i32);
        }
        if let Some(&prev) = prefix_sum.get(&sum) {
            if prev < i as i32 {
                prefix_sum.insert(sum, i as i32);
            }
        } else {
            prefix_sum.insert(sum, i as i32);
        }
    }

    sum = 0;
    prefix_sum.clear();
    prefix_sum.insert(0, -1);
    let mut min_len2 = i32::MAX;

    for (i, &num) in arr.iter().enumerate() {
        sum += num;
        if let Some(&start) = prefix_sum.get(&(sum - target)) {
            if min_len != i32::MAX {
                result = result.min((i - start) as i32 + min_len);
            }
        }
        if let Some(&prev) = prefix_sum.get(&sum) {
            if prev < i as i32 {
                prefix_sum.insert(sum, i as i32);
            }
        } else {
            prefix_sum.insert(sum, i as i32);
        }
    }

    if result == i32::MAX { -1 } else { result }
}