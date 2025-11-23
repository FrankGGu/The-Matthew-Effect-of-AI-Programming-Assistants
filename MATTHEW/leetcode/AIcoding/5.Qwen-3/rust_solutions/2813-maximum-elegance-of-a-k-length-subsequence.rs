impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_elegance(mut items: Vec<Vec<i32>>, k: i32) -> i64 {
        let k = k as usize;
        items.sort_by(|a, b| (b[1] as i64).cmp(&(a[1] as i64)));

        let mut selected = Vec::new();
        let mut duplicate_heap = BinaryHeap::new();
        let mut unique_count = 0;

        for i in 0..k {
            let item = &items[i];
            selected.push(item[1] as i64);
            if i > 0 && items[i][0] == items[i - 1][0] {
                duplicate_heap.push(item[1] as i64);
            } else {
                unique_count += 1;
            }
        }

        selected.sort_by(|a, b| b.cmp(a));

        for i in k..items.len() {
            let item = &items[i];
            if let Some(&dup) = duplicate_heap.peek() {
                if item[1] as i64 > dup {
                    selected.pop();
                    selected.push(item[1] as i64);
                    duplicate_heap.pop();
                    if items[i][0] != items[i - 1][0] {
                        unique_count += 1;
                    }
                }
            }
        }

        selected.iter().sum::<i64>() + (unique_count as i64 * unique_count as i64)
    }
}
}