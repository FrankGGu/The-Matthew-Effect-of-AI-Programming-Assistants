impl Solution {
    pub fn count_inversions(mut nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let mut temp = vec![0; n];
        Self::merge_sort_and_count_recursive(&mut nums, 0, n - 1, &mut temp)
    }

    fn merge_sort_and_count_recursive(arr: &mut Vec<i32>, start: usize, end: usize, temp: &mut Vec<i32>) -> i32 {
        if start >= end {
            return 0;
        }

        let mid = start + (end - start) / 2;
        let mut inversions = Self::merge_sort_and_count_recursive(arr, start, mid, temp);
        inversions += Self::merge_sort_and_count_recursive(arr, mid + 1, end, temp);
        inversions += Self::merge(arr, start, mid, end, temp);
        inversions
    }

    fn merge(arr: &mut Vec<i32>, start: usize, mid: usize, end: usize, temp: &mut Vec<i32>) -> i32 {
        let mut i = start; // pointer for left sub-array (arr[start..=mid])
        let mut j = mid + 1; // pointer for right sub-array (arr[mid+1..=end])
        let mut k = start; // pointer for temp array

        let mut inversions = 0;

        while i <= mid && j <= end {
            if arr[i] <= arr[j] {
                temp[k] = arr[i];
                i += 1;
            } else {
                temp[k] = arr[j];
                j += 1;
                // If arr[i] > arr[j], then arr[j] forms an inversion with arr[i]
                // and all remaining elements in the left sub-array (arr[i+1..=mid])
                inversions += (mid - i + 1) as i32;
            }
            k += 1;
        }

        while i <= mid {
            temp[k] = arr[i];
            i += 1;
            k += 1;
        }

        while j <= end {
            temp[k] = arr[j];
            j += 1;
            k += 1;
        }

        // Copy back from temp to arr
        for idx in start..=end {
            arr[idx] = temp[idx];
        }

        inversions
    }
}