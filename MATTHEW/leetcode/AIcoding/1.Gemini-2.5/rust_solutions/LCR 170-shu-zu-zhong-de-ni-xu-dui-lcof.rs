impl Solution {
    pub fn reverse_pairs(mut nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }
        Self::merge_sort_and_count(&mut nums, 0, nums.len() - 1)
    }

    fn merge_sort_and_count(arr: &mut Vec<i32>, start: usize, end: usize) -> i32 {
        if start >= end {
            return 0;
        }

        let mid = start + (end - start) / 2;
        let mut count = Self::merge_sort_and_count(arr, start, mid);
        count += Self::merge_sort_and_count(arr, mid + 1, end);

        // Count reverse pairs across the two halves
        let mut j = mid + 1;
        for i in start..=mid {
            while j <= end && arr[i] as i64 > 2 * arr[j] as i64 {
                j += 1;
            }
            count += (j - (mid + 1)) as i32;
        }

        // Merge the two sorted halves
        let mut temp = Vec::with_capacity(end - start + 1);
        let mut p1 = start;
        let mut p2 = mid + 1;

        while p1 <= mid && p2 <= end {
            if arr[p1] <= arr[p2] {
                temp.push(arr[p1]);
                p1 += 1;
            } else {
                temp.push(arr[p2]);
                p2 += 1;
            }
        }

        while p1 <= mid {
            temp.push(arr[p1]);
            p1 += 1;
        }

        while p2 <= end {
            temp.push(arr[p2]);
            p2 += 1;
        }

        for k in 0..temp.len() {
            arr[start + k] = temp[k];
        }

        count
    }
}