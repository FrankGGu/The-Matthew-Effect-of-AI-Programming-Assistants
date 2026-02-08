pub fn longest_subarray(nums: Vec<i32>, limit: i32) -> i32 {
    use std::collections::BinaryHeap;

    let mut max_heap = BinaryHeap::new();
    let mut min_heap = BinaryHeap::new();
    let mut left = 0;
    let mut result = 0;

    for right in 0..nums.len() {
        max_heap.push(nums[right]);
        min_heap.push(-nums[right]);

        while -min_heap.peek().unwrap() + max_heap.peek().unwrap() > limit {
            max_heap.retain(|&x| x != nums[left]);
            min_heap.retain(|&x| -x != nums[left]);
            left += 1;
        }
        result = result.max(right - left + 1);
    }

    result
}