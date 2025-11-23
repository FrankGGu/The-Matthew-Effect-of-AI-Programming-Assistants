impl Solution {
    pub fn reinitialize_permutation(n: i32) -> i32 {
        let mut perm: Vec<i32> = (0..n).collect();
        let mut arr: Vec<i32> = (0..n).collect();
        let mut count = 0;
        loop {
            let mut new_arr: Vec<i32> = vec![0; n as usize];
            for i in 0..n as usize {
                if i % 2 == 0 {
                    new_arr[i] = perm[i / 2];
                } else {
                    new_arr[i] = perm[n as usize / 2 + (i - 1) / 2];
                }
            }
            arr = new_arr;
            count += 1;
            if arr == (0..n).collect::<Vec<i32>>() {
                break;
            }
            perm = arr.clone();
        }
        count
    }
}