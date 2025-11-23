use std::collections::BinaryHeap;

pub fn advantage_count(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
    let mut nums1 = nums1.clone();
    let mut nums2_with_indices: Vec<(i32, usize)> = nums2.iter().enumerate().map(|(i, &num)| (num, i)).collect();
    nums1.sort();
    nums2_with_indices.sort();

    let mut result = vec![0; nums2.len()];
    let mut heap = BinaryHeap::new();

    for (num, index) in nums2_with_indices {
        heap.push((num, index));
    }

    let mut j = 0;
    for num in nums1 {
        if j < heap.len() && num > heap.peek().unwrap().0 {
            let (_, index) = heap.pop().unwrap();
            result[index] = num;
            j += 1;
        }
    }

    for (num, index) in heap {
        result[index] = nums1[j];
        j += 1;
    }

    result
}