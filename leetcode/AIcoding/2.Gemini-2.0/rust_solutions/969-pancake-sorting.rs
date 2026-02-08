impl Solution {
    pub fn pancake_sort(arr: Vec<i32>) -> Vec<i32> {
        let mut arr = arr;
        let mut flips = Vec::new();
        let n = arr.len();

        for i in (0..n).rev() {
            let mut max_idx = 0;
            for j in 0..=i {
                if arr[j] > arr[max_idx] {
                    max_idx = j;
                }
            }

            if max_idx != i {
                if max_idx != 0 {
                    arr[0..=max_idx].reverse();
                    flips.push((max_idx + 1) as i32);
                }
                arr[0..=i].reverse();
                flips.push((i + 1) as i32);
            }
        }

        flips
    }
}