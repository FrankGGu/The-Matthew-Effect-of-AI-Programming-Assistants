impl Solution {
    pub fn maximum_segment_sum(nums: Vec<i32>, remove_queries: Vec<i32>) -> Vec<i64> {
        let n = nums.len();
        let mut parent: Vec<usize> = (0..n).collect();
        let mut sum: Vec<i64> = nums.iter().map(|&x| x as i64).collect();
        let mut res = vec![0; remove_queries.len()];
        let mut max_sum = 0;

        for i in (1..remove_queries.len()).rev() {
            let pos = remove_queries[i] as usize;
            let num = nums[pos] as i64;
            sum[pos] = num;
            if pos > 0 && sum[pos - 1] != 0 {
                Self::union(&mut parent, &mut sum, pos - 1, pos);
            }
            if pos < n - 1 && sum[pos + 1] != 0 {
                Self::union(&mut parent, &mut sum, pos, pos + 1);
            }
            max_sum = max_sum.max(sum[pos]);
            res[i - 1] = max_sum;
        }

        res
    }

    fn find(parent: &mut Vec<usize>, x: usize) -> usize {
        if parent[x] != x {
            parent[x] = Self::find(parent, parent[x]);
        }
        parent[x]
    }

    fn union(parent: &mut Vec<usize>, sum: &mut Vec<i64>, x: usize, y: usize) {
        let root_x = Self::find(parent, x);
        let root_y = Self::find(parent, y);
        if root_x != root_y {
            parent[root_y] = root_x;
            sum[root_x] += sum[root_y];
        }
    }
}