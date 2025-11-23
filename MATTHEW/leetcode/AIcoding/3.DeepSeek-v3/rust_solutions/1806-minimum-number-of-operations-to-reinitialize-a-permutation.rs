impl Solution {
    pub fn reinitialize_permutation(n: i32) -> i32 {
        let mut perm: Vec<i32> = (0..n).collect();
        let original = perm.clone();
        let mut operations = 0;
        loop {
            let mut arr = vec![0; n as usize];
            for i in 0..n as usize {
                if i % 2 == 0 {
                    arr[i] = perm[i / 2];
                } else {
                    arr[i] = perm[n as usize / 2 + (i - 1) / 2];
                }
            }
            operations += 1;
            if arr == original {
                break;
            }
            perm = arr;
        }
        operations
    }
}