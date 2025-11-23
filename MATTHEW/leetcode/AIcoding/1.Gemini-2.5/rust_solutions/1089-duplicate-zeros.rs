impl Solution {
    pub fn duplicate_zeros(arr: &mut Vec<i32>) {
        let n = arr.len();
        if n == 0 {
            return;
        }

        let mut zeros_to_duplicate = 0;
        let mut last_possible_src = n - 1; // Index in original array of the last element that will be copied

        // First pass: Determine how many zeros need to be duplicated and the effective end of the original array to consider
        for i in 0..n {
            if arr[i] == 0 {
                // Check if this zero would only fit once (i.e., it's the last element in the target array)
                // This happens if duplicating it fully would push it beyond 'n' by exactly one spot.
                if i + zeros_to_duplicate + 1 >= n {
                    last_possible_src = i;
                    break;
                }
                zeros_to_duplicate += 1;
            }
            // Check if adding this element (and its duplicated zero if applicable) pushes us past the array bounds
            // 'i + zeros_to_duplicate' represents the index where the current element 'arr[i]' (or its first copy if zero)
            // would be placed in the modified array. If this index is 'n-1' or more, it's the last element.
            if i + zeros_to_duplicate >= n - 1 {
                last_possible_src = i;
                break;
            }
        }

        let mut src_ptr = last_possible_src;
        let mut dest_ptr = n - 1;

        // Handle the special case where the last element copied is a zero that only gets one spot.
        // This condition is exactly what caused the 'break' in the first loop when 'i + zeros_to_duplicate + 1 >= n' was true.
        if arr[src_ptr] == 0 && (src_ptr + zeros_to_duplicate + 1) >= n {
            arr[dest_ptr] = 0;
            dest_ptr -= 1;
            src_ptr -= 1;
        }

        // Second pass: Copy elements from right to left
        while dest_ptr >= 0 && src_ptr >= 0 {
            if arr[src_ptr] == 0 {
                arr[dest_ptr] = 0;
                dest_ptr -= 1;
                arr[dest_ptr] = 0;
                dest_ptr -= 1;
            } else {
                arr[dest_ptr] = arr[src_ptr];
                dest_ptr -= 1;
            }
            src_ptr -= 1;
        }
    }
}