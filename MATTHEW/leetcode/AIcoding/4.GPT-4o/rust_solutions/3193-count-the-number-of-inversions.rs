impl Solution {
    pub fn count_inversions(arr: Vec<i32>) -> i32 {
        fn merge_and_count(arr: &mut Vec<i32>, temp: &mut Vec<i32>, left: usize, mid: usize, right: usize) -> i32 {
            let mut i = left;
            let mut j = mid + 1;
            let mut k = left;
            let mut inv_count = 0;

            while i <= mid && j <= right {
                if arr[i] <= arr[j] {
                    temp[k] = arr[i];
                    i += 1;
                } else {
                    temp[k] = arr[j];
                    inv_count += (mid - i + 1) as i32;
                    j += 1;
                }
                k += 1;
            }

            while i <= mid {
                temp[k] = arr[i];
                i += 1;
                k += 1;
            }

            while j <= right {
                temp[k] = arr[j];
                j += 1;
                k += 1;
            }

            for i in left..=right {
                arr[i] = temp[i];
            }

            inv_count
        }

        fn merge_sort_and_count(arr: &mut Vec<i32>, temp: &mut Vec<i32>, left: usize, right: usize) -> i32 {
            if left >= right {
                return 0;
            }

            let mid = left + (right - left) / 2;
            let mut inv_count = 0;

            inv_count += merge_sort_and_count(arr, temp, left, mid);
            inv_count += merge_sort_and_count(arr, temp, mid + 1, right);
            inv_count += merge_and_count(arr, temp, left, mid, right);

            inv_count
        }

        let n = arr.len();
        let mut temp = vec![0; n];
        merge_sort_and_count(&mut arr.clone(), &mut temp, 0, n - 1)
    }
}