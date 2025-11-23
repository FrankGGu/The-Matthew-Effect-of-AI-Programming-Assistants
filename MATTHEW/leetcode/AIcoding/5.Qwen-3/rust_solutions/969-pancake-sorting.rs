struct Solution;

impl Solution {
    pub fn pancake_sort(arr: &mut Vec<i32>) -> Vec<i32> {
        let mut n = arr.len();
        let mut res = Vec::new();

        for i in (1..=n).rev() {
            let mut max_index = 0;
            for j in 0..i {
                if arr[j] > arr[max_index] {
                    max_index = j;
                }
            }

            if max_index == i - 1 {
                continue;
            }

            if max_index != 0 {
                res.push(max_index as i32 + 1);
                arr[0..=max_index].reverse();
            }

            res.push(i as i32);
            arr[0..i].reverse();
        }

        res
    }
}