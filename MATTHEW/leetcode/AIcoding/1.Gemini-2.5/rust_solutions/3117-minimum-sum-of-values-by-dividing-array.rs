struct SparseTable {
    st: Vec<Vec<i64>>,
    log_table: Vec<usize>,
}

impl SparseTable {
    fn new(arr: &[i64]) -> Self {
        let n = arr.len();
        if n == 0 {
            return SparseTable { st: Vec::new(), log_table: Vec::new() };
        }

        // max_log is ceil(log2(n))
        let max_log = (n as f64).log2().ceil() as usize;
        let mut st = vec![vec![0; max_log]; n];
        let mut log_table = vec![0; n + 1];

        for i in 0..n {
            st[i][0] = arr[i];
        }

        if n > 1 {
            log_table[1] = 0;
            for i in 2..=n {
                log_table[i] = log_table[i / 2] + 1;
            }
        }

        for p in 1..max_log {
            for i in 0..=(n - (1 << p)) {
                st[i][p] = st[i][p - 1].min(st[i + (1 << (p - 1))][p - 1]);
            }
        }

        SparseTable { st, log_table }
    }

    fn query(&self, l: usize, r: usize) -> i64 {
        if l > r {
            return i64::MAX; // Represents an empty range, returning a value that won't affect min()
        }
        let p = self.log_table[r - l + 1];
        self.st[l][p].min(self.st[r - (1 << p) + 1][p])
    }
}

impl Solution {
    pub fn minimum_sum_of_values(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        // The problem states 0 < i < j < n - 1.
        // This implies:
        // i >= 1
        // j >= i + 1
        // j <= n - 2
        //
        // Combining these:
        // 1 <= i
        // i + 1 <= j <= n - 2
        // For j to exist, i + 1 <= n - 2 => i <= n - 3.
        // So, 1 <= i <= n - 3.
        //
        // For i to exist, 1 <= n - 3 => n >= 4.
        // If n < 4, no valid split is possible.
        if n < 4 {
            return -1;
        }

        let nums_i64: Vec<i64> = nums.into_iter().map(|x| x as i64).collect();

        // 1. Compute prefix maximums: pref_max[k] = max(nums[0...k])
        let mut pref_max = vec![0; n];
        pref_max[0] = nums_i64[0];
        for i in 1..n {
            pref_max[i] = pref_max[i - 1].max(nums_i64[i]);
        }

        // 2. Compute suffix maximums: suff_max[k] = max(nums[k...n-1])
        let mut suff_max = vec![0; n];
        suff_max[n - 1] = nums_i64[n - 1];
        for i in (0..n - 1).rev() {
            suff_max[i] = suff_max[i + 1].max(nums_i64[i]);
        }

        // 3. Compute prev_greater_strict and next_greater_strict
        // prev_greater_strict[k]: largest index p < k such that nums[p] > nums[k]. If none, -1.
        let mut prev_greater_strict = vec![-1; n];
        let mut stack: Vec<usize> = Vec::new();
        for i in 0..n {
            while let Some(&top_idx) = stack.last() {
                if nums_i64[top_idx] > nums_i64[i] {
                    prev_greater_strict[i] = top_idx as i32;
                    break;
                } else {
                    stack.pop();
                }
            }
            stack.push(i);
        }

        // next_greater_strict[k]: smallest index p > k such that nums[p] > nums[k]. If none, n.
        let mut next_greater_strict = vec![n as i32; n];
        stack.clear();
        for i in (0..n).rev() {
            while let Some(&top_idx) = stack.last() {
                if nums_i64[top_idx] > nums_i64[i] {
                    next_greater_strict[i] = top_idx as i32;
                    break;
                } else {
                    stack.pop();
                }
            }
            stack.push(i);
        }

        // 4. Build Sparse Tables for range minimum queries on pref_max and suff_max
        let pref_max_st = SparseTable::new(&pref_max);
        let suff_max_st = SparseTable::new(&suff_max);

        // 5. Iterate k (index of max2) and find minimum total sum
        let mut min_total_sum = i64::MAX;

        // k is the index of the element nums[k] which acts as max2.
        // This means nums[k] is the maximum value in the second segment nums[i...j-1].
        // So, i <= k <= j-1.
        // From problem constraints: 0 < i < j < n-1.
        // This implies:
        // 1 <= i <= k
        // k+1 <= j <= n-2

        // Also, for nums[k] to be the maximum in nums[i...j-1]:
        // All elements nums[x] for x in [i, k-1] must be <= nums[k].
        // This means i must be > prev_greater_strict[k].
        // So, i >= prev_greater_strict[k] + 1.
        //
        // All elements nums[x] for x in [k+1, j-1] must be <= nums[k].
        // This means j-1 must be < next_greater_strict[k].
        // So, j <= next_greater_strict[k] - 1.

        // Combining all conditions for i and j:
        // i must be in [max(1, prev_greater_strict[k]+1), k]
        // j must be in [k+1, min(n-2, next_greater_strict[k]-1)]

        for k in 1..n - 1 { // k can range from 1 to n-2 (inclusive)
            let actual_min_i = (prev_greater_strict[k] + 1).max(1) as usize;
            let actual_max_i = k;

            // Query for max1 = min(pref_max[i-1]) over valid i's
            let min1_val = if actual_min_i <= actual_max_i {
                pref_max_st.query(actual_min_i - 1, actual_max_i - 1)
            } else {
                i64::MAX
            };

            let actual_min_j = k + 1;
            let actual_max_j = (next_greater_strict[k] - 1).min((n - 2) as i32) as usize;

            // Query for max3 = min(suff_max[j]) over valid j's
            let min3_val = if actual_min_j <= actual_max_j {
                suff_max_st.query(actual_min_j, actual_max_j)
            } else {
                i64::MAX
            };

            if min1_val != i64::MAX && min3_val != i64::MAX {
                min_total_sum = min_total_sum.min(min1_val + nums_i64[k] + min3_val);
            }
        }

        if min_total_sum == i64::MAX {
            -1
        } else {
            min_total_sum
        }
    }
}