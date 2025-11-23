use std::collections::BTreeMap;

impl Solution {
    pub fn prev_permutation_with_one_swap(mut arr: Vec<i32>) -> Vec<i32> {
        let n = arr.len();
        if n <= 1 {
            return arr;
        }

        // BTreeMap to store elements and their rightmost indices encountered so far
        // while iterating from right to left.
        // Key: value, Value: index
        let mut right_elements: BTreeMap<i32, usize> = BTreeMap::new();

        // Iterate from right to left, starting from the second to last element.
        // We are looking for the rightmost `i` such that arr[i] can be swapped
        // with some arr[j] (j > i) to make the number smaller.
        for i in (0..n - 1).rev() {
            // Add arr[i+1] to the map.
            // We use `entry().or_insert()` to ensure that if a value already exists,
            // its existing index (which would be the rightmost one encountered so far) is kept.
            // This correctly maintains the rightmost index for each value in the suffix arr[i+1...n-1].
            right_elements.entry(arr[i + 1]).or_insert(i + 1);

            // Find the largest value `val_j` in `right_elements` that is strictly less than `arr[i]`.
            // `right_elements.range(..arr[i])` gives an iterator of (value, index) pairs
            // where value < arr[i].
            // `.last()` on this iterator will give the pair with the largest value (and its rightmost index).
            if let Some((&val_j, &idx_j)) = right_elements.range(..arr[i]).last() {
                // Found a suitable `arr[j]` (which is `val_j`) at index `idx_j`.
                // This `i` is the rightmost possible index to make a swap.
                // `val_j` is the largest element to the right of `i` that is smaller than `arr[i]`.
                // Swapping these two elements results in the largest possible smaller permutation.
                let temp = arr[i];
                arr[i] = arr[idx_j];
                arr[idx_j] = temp;
                return arr;
            }
        }

        // If no such swap is found, the array is already the smallest permutation
        // achievable with one swap (e.g., [1,2,3] or [1,1,5]).
        // In this case, return the original array.
        arr
    }
}