struct Solution;

impl Solution {
    pub fn next_greater_element_iv(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut ans = vec![-1; n];

        // s1 stores indices `p` such that `nums[p]` is waiting for its first NGE.
        // `nums[p]` values are in decreasing order from bottom to top of stack.
        let mut s1: Vec<usize> = Vec::new();

        // s2 stores indices `p` such that `nums[p]` has found its first NGE
        // and is now waiting for its second NGE.
        // `nums[p]` values are in decreasing order from bottom to top of stack.
        let mut s2: Vec<usize> = Vec::new();

        for i in 0..n {
            let num = nums[i];

            // Step 1: Process elements in s2 that find their second NGE.
            // These elements are popped from s2, and their answer is `num`.
            // s2 is maintained as a decreasing stack, so we pop from the top.
            while let Some(&p) = s2.last() {
                if nums[p] < num {
                    ans[p] = num;
                    s2.pop();
                } else {
                    // s2 is decreasing, so if the top element is not smaller,
                    // no other element in s2 will be smaller than `num`.
                    break; 
                }
            }

            // Step 2: Process elements in s1 that find their first NGE.
            // These elements are moved to a temporary list and then pushed to s2.
            let mut temp_s1_to_s2: Vec<usize> = Vec::new();
            while let Some(&p) = s1.last() {
                if nums[p] < num {
                    temp_s1_to_s2.push(s1.pop().unwrap());
                } else {
                    // s1 is decreasing.
                    break; 
                }
            }

            // Step 3: Add current index `i` to s1 (it's waiting for its first NGE).
            s1.push(i);

            // Step 4: Add elements from temp_s1_to_s2 to s2.
            // These elements are now waiting for their second NGE.
            // `temp_s1_to_s2` contains indices in increasing order of their `nums` values
            // because they were popped from a decreasing stack `s1`.
            // To maintain `s2` as a decreasing stack, we push them in reverse order.
            for &p in temp_s1_to_s2.iter().rev() {
                s2.push(p);
            }
        }

        ans
    }
}