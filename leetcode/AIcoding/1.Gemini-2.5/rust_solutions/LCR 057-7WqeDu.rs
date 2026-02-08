use std::collections::BTreeSet;

impl Solution {
    pub fn contains_nearby_almost_duplicate(nums: Vec<i32>, k: i32, t: i32) -> bool {
        let k = k as usize;
        let mut set: BTreeSet<i32> = BTreeSet::new();

        for i in 0..nums.len() {
            let num = nums[i];

            // Calculate the lower and upper bounds for the search range.
            // Use checked_sub/add to handle potential i32 overflow/underflow,
            // capping at i32::MIN/MAX if overflow/underflow occurs.
            // This ensures the range passed to BTreeSet::range is valid for i32.
            let lower_bound = num.checked_sub(t).unwrap_or(i32::MIN);
            let upper_bound = num.checked_add(t).unwrap_or(i32::MAX);

            // Check if any element exists in the set within the range [lower_bound, upper_bound].
            // If the iterator is not empty, it means such an element exists, and we found a pair.
            if set.range(lower_bound..=upper_bound).next().is_some() {
                return true;
            }

            // Add the current number to the set for future comparisons.
            set.insert(num);

            // If the window size exceeds k, remove the element that is now out of the window.
            // The window consists of elements from nums[i-k] to nums[i].
            // When processing nums[i], if i >= k, then nums[i-k] is no longer in the window.
            if i >= k {
                set.remove(&nums[i - k]);
            }
        }

        // If the loop completes without finding any such pair, return false.
        false
    }
}