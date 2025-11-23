struct Solution;

impl Solution {
    pub fn count_range_sum(nums: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let n = nums.len();
        let mut prefix_sums = vec![0i64; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i] as i64;
        }

        Self::merge_sort_and_count(&mut prefix_sums, 0, n + 1, lower as i64, upper as i64) as i32
    }

    fn merge_sort_and_count(
        prefix_sums: &mut Vec<i64>,
        start: usize,
        end: usize,
        lower: i64,
        upper: i64,
    ) -> i64 {
        if end - start <= 1 {
            return 0;
        }

        let mid = start + (end - start) / 2;
        let mut count = 0i64;

        count += Self::merge_sort_and_count(prefix_sums, start, mid, lower, upper);
        count += Self::merge_sort_and_count(prefix_sums, mid, end, lower, upper);

        let mut k = mid; // Pointer for the lower bound (prefix_sums[j] >= prefix_sums[i] + lower)
        let mut l = mid; // Pointer for the upper bound (prefix_sums[j] <= prefix_sums[i] + upper)

        for i in start..mid {
            // Find the first element in the right half (prefix_sums[k]) such that prefix_sums[k] >= prefix_sums[i] + lower
            while k < end && prefix_sums[k] < prefix_sums[i] + lower {
                k += 1;
            }
            // Find the first element in the right half (prefix_sums[l]) such that prefix_sums[l] > prefix_sums[i] + upper
            while l < end && prefix_sums[l] <= prefix_sums[i] + upper {
                l += 1;
            }
            count += (l - k) as i64;
        }

        // Merge the two sorted halves back into prefix_sums[start..end]
        let mut temp = Vec::with_capacity(end - start);
        let mut i = start;
        let mut j = mid;

        while i < mid && j < end {
            if prefix_sums[i] <= prefix_sums[j] {
                temp.push(prefix_sums[i]);
                i += 1;
            } else {
                temp.push(prefix_sums[j]);
                j += 1;
            }
        }

        while i < mid {
            temp.push(prefix_sums[i]);
            i += 1;
        }
        while j < end {
            temp.push(prefix_sums[j]);
            j += 1;
        }

        for x in 0..temp.len() {
            prefix_sums[start + x] = temp[x];
        }

        count
    }
}