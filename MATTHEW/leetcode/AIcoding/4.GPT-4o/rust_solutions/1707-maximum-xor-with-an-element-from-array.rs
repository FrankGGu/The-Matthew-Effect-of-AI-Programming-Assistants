pub struct Solution;

impl Solution {
    pub fn maximize_xor(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut sorted_queries: Vec<(i32, i32, usize)> = queries.iter()
            .enumerate()
            .map(|(i, &q)| (q[1], q[0], i))
            .collect();

        sorted_queries.sort_unstable();
        let mut nums = nums;
        nums.sort_unstable();

        let mut result = vec![0; queries.len()];
        let mut trie = vec![vec![0; 2]; 1];
        let mut node_count = 1;

        let mut j = 0;

        for (limit, index, original_index) in sorted_queries {
            while j < nums.len() && nums[j] <= limit {
                let mut node = 0;
                for k in (0..32).rev() {
                    let bit = (nums[j] >> k) & 1;
                    if trie[node][bit as usize] == 0 {
                        trie[node][bit as usize] = node_count;
                        node_count += 1;
                    }
                    node = trie[node][bit as usize];
                }
                j += 1;
            }

            let mut max_xor = 0;
            let mut node = 0;
            for k in (0..32).rev() {
                let bit = (index >> k) & 1;
                if trie[node][1 - bit as usize] != 0 {
                    max_xor |= 1 << k;
                    node = trie[node][1 - bit as usize];
                } else {
                    node = trie[node][bit as usize];
                }
            }
            result[original_index] = max_xor;
        }

        result
    }
}