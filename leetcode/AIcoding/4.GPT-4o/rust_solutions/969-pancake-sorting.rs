impl Solution {
    pub fn pancake_sort(arr: Vec<i32>) -> Vec<i32> {
        let mut arr = arr;
        let mut result = Vec::new();
        let n = arr.len();

        for i in (1..=n).rev() {
            let max_index = arr.iter().take(i).enumerate().max_by_key(|&(_, &val)| val).unwrap().0;
            if max_index != i - 1 {
                if max_index > 0 {
                    result.push(max_index as i32 + 1);
                    arr[..=max_index].reverse();
                }
                result.push(i as i32);
                arr[..i].reverse();
            }
        }

        result
    }
}