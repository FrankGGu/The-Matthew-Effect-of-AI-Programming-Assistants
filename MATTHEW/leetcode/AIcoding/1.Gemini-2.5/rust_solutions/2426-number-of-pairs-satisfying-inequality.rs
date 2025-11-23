impl Solution {
    pub fn number_of_pairs(nums1: Vec<i32>, nums2: Vec<i32>, diff: i32) -> i64 {
        let n = nums1.len();
        let mut arr: Vec<i32> = Vec::with_capacity(n);
        for k in 0..n {
            arr.push(nums1[k] - nums2[k]);
        }

        Self::merge_sort_and_count(&mut arr, diff)
    }

    fn merge_sort_and_count(arr: &mut [i32], diff: i32) -> i64 {
        let n = arr.len();
        if n <= 1 {
            return 0;
        }

        let mid = n / 2;
        let (left_half, right_half) = arr.split_at_mut(mid);

        let mut count = Self::merge_sort_and_count(left_half, diff);
        count += Self::merge_sort_and_count(right_half, diff);

        let mut k = 0;
        for i in 0..left_half.len() {
            while k < right_half.len() && left_half[i] > right_half[k] + diff {
                k += 1;
            }
            count += (right_half.len() - k) as i64;
        }

        let mut merged = Vec::with_capacity(n);
        let mut p1 = 0;
        let mut p2 = 0;
        while p1 < left_half.len() && p2 < right_half.len() {
            if left_half[p1] <= right_half[p2] {
                merged.push(left_half[p1]);
                p1 += 1;
            } else {
                merged.push(right_half[p2]);
                p2 += 1;
            }
        }
        while p1 < left_half.len() {
            merged.push(left_half[p1]);
            p1 += 1;
        }
        while p2 < right_half.len() {
            merged.push(right_half[p2]);
            p2 += 1;
        }

        for i in 0..n {
            arr[i] = merged[i];
        }

        count
    }
}