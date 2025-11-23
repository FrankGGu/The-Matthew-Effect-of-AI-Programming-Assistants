struct Solution;

impl Solution {
    pub fn count_range_sum(nums: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let mut prefix_sums = vec![0];
        for &num in &nums {
            prefix_sums.push(prefix_sums.last().unwrap() + num);
        }

        Self::merge_sort(&mut prefix_sums, 0, prefix_sums.len() as i32 - 1, lower, upper)
    }

    fn merge_sort(arr: &mut Vec<i64>, left: i32, right: i32, lower: i32, upper: i32) -> i32 {
        if left >= right {
            return 0;
        }

        let mid = (left + right) / 2;
        let mut count = Self::merge_sort(arr, left, mid, lower, upper);
        count += Self::merge_sort(arr, mid + 1, right, lower, upper);

        let mut i = left;
        let mut j = mid + 1;
        let mut k = left;

        while i <= mid {
            while j <= right && arr[j] - arr[i] < lower {
                j += 1;
            }
            let mut l = j;
            while l <= right && arr[l] - arr[i] <= upper {
                l += 1;
            }
            count += (l - j) as i32;

            while k <= right && arr[k] < arr[i] {
                k += 1;
            }

            if k <= right {
                arr.swap(k, i);
            } else {
                break;
            }

            i += 1;
        }

        Self::merge(arr, left, mid, right);

        count
    }

    fn merge(arr: &mut Vec<i64>, left: i32, mid: i32, right: i32) {
        let mut temp = vec![];
        let mut i = left;
        let mut j = mid + 1;

        while i <= mid && j <= right {
            if arr[i] <= arr[j] {
                temp.push(arr[i]);
                i += 1;
            } else {
                temp.push(arr[j]);
                j += 1;
            }
        }

        while i <= mid {
            temp.push(arr[i]);
            i += 1;
        }

        while j <= right {
            temp.push(arr[j]);
            j += 1;
        }

        for idx in 0..temp.len() {
            arr[left as usize + idx] = temp[idx];
        }
    }
}