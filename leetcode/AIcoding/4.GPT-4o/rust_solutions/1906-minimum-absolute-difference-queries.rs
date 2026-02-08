pub fn minimum_absolute_difference(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
    use std::collections::BTreeSet;

    let mut results = Vec::new();
    let mut sorted_nums: BTreeSet<i32> = BTreeSet::new();

    for (l, r) in queries {
        sorted_nums.clear();
        for &num in &nums[l as usize..=r as usize] {
            sorted_nums.insert(num);
        }

        let mut min_diff = i32::MAX;
        let mut prev = None;

        for &num in sorted_nums.iter() {
            if let Some(p) = prev {
                min_diff = min_diff.min(num - p);
            }
            prev = Some(num);
        }

        results.push(if min_diff == i32::MAX { -1 } else { min_diff });
    }

    results
}