impl Solution {
    pub fn subarray_ranges(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut total_sum = 0i64;

        for i in 0..n {
            let mut max_stack = vec![];
            let mut min_stack = vec![];
            let mut max_sum = 0i64;
            let mut min_sum = 0i64;

            for j in i..n {
                while let Some(&top) = max_stack.last() {
                    if nums[top] < nums[j] {
                        max_stack.pop();
                    } else {
                        break;
                    }
                }
                max_stack.push(j);

                while let Some(&top) = min_stack.last() {
                    if nums[top] > nums[j] {
                        min_stack.pop();
                    } else {
                        break;
                    }
                }
                min_stack.push(j);

                max_sum += nums[max_stack[0]] as i64;
                min_sum += nums[min_stack[0]] as i64;
            }

            total_sum += max_sum - min_sum;
        }

        total_sum
    }
}