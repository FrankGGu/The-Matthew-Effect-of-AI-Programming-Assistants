use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct Solution;

impl Solution {
    pub fn result_array(nums: Vec<i32>) -> Vec<i32> {
        let mut arr1 = vec![nums[0]];
        let mut arr2 = vec![nums[1]];
        let mut heap1 = BinaryHeap::new();
        let mut heap2 = BinaryHeap::new();
        heap1.push(Reverse(nums[0]));
        heap2.push(Reverse(nums[1]));

        for &num in nums.iter().skip(2) {
            let cnt1 = arr1.len() - Solution::lower_bound(&heap1, num);
            let cnt2 = arr2.len() - Solution::lower_bound(&heap2, num);

            if cnt1 > cnt2 {
                arr1.push(num);
                heap1.push(Reverse(num));
            } else if cnt1 < cnt2 {
                arr2.push(num);
                heap2.push(Reverse(num));
            } else {
                if arr1.len() <= arr2.len() {
                    arr1.push(num);
                    heap1.push(Reverse(num));
                } else {
                    arr2.push(num);
                    heap2.push(Reverse(num));
                }
            }
        }

        arr1.extend(arr2);
        arr1
    }

    fn lower_bound(heap: &BinaryHeap<Reverse<i32>>, num: i32) -> usize {
        let mut count = 0;
        for &Reverse(x) in heap.iter() {
            if x < num {
                count += 1;
            }
        }
        count
    }
}