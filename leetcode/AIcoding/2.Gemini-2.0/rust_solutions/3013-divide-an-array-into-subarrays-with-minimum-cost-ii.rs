use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimum_cost(nums: Vec<i32>, k: i32, dist: i32) -> i64 {
        let n = nums.len();
        let k = k as usize;
        let dist = dist as usize;

        let mut selected: BinaryHeap<i32> = BinaryHeap::new();
        let mut unselected: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        for i in 1..=dist + 1 {
            unselected.push(Reverse(nums[i]));
        }

        for _ in 0..k - 1 {
            let val = unselected.pop().unwrap().0;
            selected.push(val);
        }

        let mut ans = i64::MAX;
        for i in 0..=n - dist - 1 - 1 {
            let mut current_cost: i64 = nums[0] as i64;
            let mut temp_selected = selected.clone();
            let mut temp_unselected = unselected.clone();

            let mut current_selected: Vec<i32> = vec![];
            while let Some(val) = temp_selected.pop() {
                current_cost += val as i64;
                current_selected.push(val);
            }

            for val in current_selected.iter() {
                selected.push(*val);
            }

            let next_index = dist + 1 + i;
            if next_index < n {
                unselected.push(Reverse(nums[next_index]));
            }

            if i > 0 {
                let removed_index = i;
                let mut found = false;
                let mut temp_selected2 = BinaryHeap::new();
                while let Some(val) = selected.pop() {
                    if val == nums[removed_index] && !found {
                        found = true;
                    } else {
                        temp_selected2.push(val);
                    }
                }
                if found {
                    while let Some(Reverse(val)) = unselected.pop() {
                        if temp_selected2.len() < k - 1 {
                            temp_selected2.push(val);
                        } else {
                            unselected.push(Reverse(val));
                            break;
                        }
                    }

                    selected = temp_selected2;
                    while let Some(Reverse(val)) = unselected.pop() {
                        if selected.len() < k - 1 {
                            selected.push(val);
                        } else {
                            unselected.push(Reverse(val));
                            break;
                        }
                    }
                } else {
                    let mut temp_unselected2 = BinaryHeap::new();
                    while let Some(Reverse(val)) = unselected.pop() {
                        if val == nums[removed_index] && !found {
                            found = true;
                        } else {
                            temp_unselected2.push(Reverse(val));
                        }
                    }
                    unselected = temp_unselected2;
                }
            }

            let mut temp_selected = selected.clone();
            while let Some(val) = temp_selected.pop() {
                current_cost += val as i64;
            }

            ans = ans.min(current_cost);
            selected = BinaryHeap::new();
            unselected = BinaryHeap::new();

            for j in 1 + i + 1..=dist + 1 + i + 1 {
                unselected.push(Reverse(nums[j]));
            }

            for _ in 0..k - 1 {
                let val = unselected.pop().unwrap().0;
                selected.push(val);
            }
        }

        ans
    }
}