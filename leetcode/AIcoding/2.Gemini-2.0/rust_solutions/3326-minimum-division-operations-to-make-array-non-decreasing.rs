impl Solution {
    pub fn minimum_division_operations(nums: Vec<i32>, divisors: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = divisors.len();
        let mut nums = nums;

        let mut q = std::collections::VecDeque::new();
        q.push_back((nums.clone(), 0));

        let mut visited = std::collections::HashSet::new();
        visited.insert(nums.clone());

        let mut steps = 0;

        while !q.is_empty() {
            let len = q.len();
            for _ in 0..len {
                let (curr_nums, curr_idx) = q.pop_front().unwrap();

                if curr_nums.windows(2).all(|w| w[0] <= w[1]) {
                    return steps;
                }

                if curr_idx < m {
                    let divisor = divisors[curr_idx];
                    let mut next_nums1 = curr_nums.clone();
                    for i in 0..n {
                        if divisor != 1 && next_nums1[i] % divisor == 0 {
                            next_nums1[i] /= divisor;
                        }
                    }

                    if !visited.contains(&next_nums1) {
                        visited.insert(next_nums1.clone());
                        q.push_back((next_nums1, curr_idx + 1));
                    }

                    let mut next_nums2 = curr_nums.clone();
                    if !visited.contains(&next_nums2) {
                        visited.insert(next_nums2.clone());
                        q.push_back((next_nums2, curr_idx + 1));
                    }
                } else {
                    if !visited.contains(&curr_nums) {
                        visited.insert(curr_nums.clone());
                        q.push_back((curr_nums, m));
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}