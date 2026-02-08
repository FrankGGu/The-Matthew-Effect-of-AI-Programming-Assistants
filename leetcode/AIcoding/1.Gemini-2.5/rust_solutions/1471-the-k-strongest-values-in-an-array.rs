use std::cmp::Ordering;

impl Solution {
    pub fn get_strongest(mut arr: Vec<i32>, k: i32) -> Vec<i32> {
        let n = arr.len();

        // 1. Sort the array to find the median.
        // This modifies `arr` in place.
        arr.sort_unstable();

        // 2. Calculate the median 'm'.
        // The median is the element at index ((n - 1) / 2) after sorting.
        let m = arr[(n - 1) / 2];

        // 3. Sort 'arr' again using the custom comparator.
        // This modifies `arr` in place, overwriting the previous sort.
        // The comparator sorts in descending order of strength.
        // Strength is defined by:
        // a) |arr[i] - m| (descending)
        // b) arr[i] (descending) if |arr[i] - m| are equal
        arr.sort_unstable_by(|&a, &b| {
            let diff_a = (a - m).abs();
            let diff_b = (b - m).abs();

            // Compare by absolute difference.
            // If diff_a > diff_b, then a is stronger, so it should come before b (Ordering::Less).
            // If diff_a < diff_b, then b is stronger, so it should come before a (Ordering::Greater).
            // This is achieved by reversing the natural comparison.
            diff_a.cmp(&diff_b)
                  // If absolute differences are equal, compare by value.
                  // If a > b, then a is stronger, so it should come before b (Ordering::Less).
                  // This is also achieved by reversing the natural comparison.
                  .then_with(|| a.cmp(&b))
                  // Reverse the final comparison result to get descending order for both criteria.
                  .reverse()
        });

        // 4. Take the first 'k' elements from the sorted array.
        arr.into_iter().take(k as usize).collect()
    }
}