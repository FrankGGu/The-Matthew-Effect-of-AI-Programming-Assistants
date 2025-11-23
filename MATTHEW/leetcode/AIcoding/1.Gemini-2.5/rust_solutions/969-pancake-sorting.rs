impl Solution {
    pub fn pancake_sort(mut arr: Vec<i32>) -> Vec<i32> {
        let n = arr.len();
        let mut res = Vec::new();

        // Helper function to perform a flip
        // Reverses the sub-array arr[0...k-1]
        fn flip(arr: &mut Vec<i32>, k: usize) {
            arr[0..k].reverse();
        }

        // Iterate from n down to 1 (representing the value to place)
        for current_val_to_place in (1..=n).rev() {
            // Find the index of the current_val_to_place in the unsorted part
            // The unsorted part is arr[0...current_val_to_place-1]
            let mut idx = 0;
            for i in 0..current_val_to_place {
                if arr[i] == current_val_to_place as i32 {
                    idx = i;
                    break;
                }
            }

            // If the element is already in its correct sorted position, skip
            if idx == current_val_to_place - 1 {
                continue;
            }

            // Step 1: Bring the element to the front (index 0)
            // Only if it's not already at index 0
            if idx != 0 {
                flip(&mut arr, idx + 1);
                res.push((idx + 1) as i32);
            }

            // Step 2: Bring the element from the front to its final sorted position
            // The final position for current_val_to_place is current_val_to_place - 1 (0-indexed)
            // So we need to flip the first `current_val_to_place` elements.
            flip(&mut arr, current_val_to_place);
            res.push(current_val_to_place as i32);
        }

        res
    }
}