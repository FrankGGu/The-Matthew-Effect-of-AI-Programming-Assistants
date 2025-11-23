impl Solution {
    pub fn can_be_increasing(nums: Vec<i32>) -> bool {
        let mut prev = nums[0];
        let mut removed = false;

        for i in 1..nums.len() {
            if nums[i] <= prev {
                if removed {
                    return false;
                }

                removed = true;

                if i > 1 && nums[i] <= nums[i - 2] {
                    prev = nums[i];
                }
            } else {
                prev = nums[i];
            }
        }

        true
    }

    pub fn can_sort_array(nums: Vec<i32>) -> bool {
        let mut chunks: Vec<Vec<i32>> = Vec::new();
        let mut current_chunk: Vec<i32> = Vec::new();

        for &num in &nums {
            if current_chunk.is_empty() || (num & (num - 1) == current_chunk.last().unwrap() & (current_chunk.last().unwrap() - 1)) {
                current_chunk.push(num);
            } else {
                chunks.push(current_chunk);
                current_chunk = vec![num];
            }
        }

        chunks.push(current_chunk);

        for i in 0..chunks.len() - 1 {
            if *chunks[i].last().unwrap() > *chunks[i + 1].first().unwrap() {
                return false;
            }
        }

        true
    }
}