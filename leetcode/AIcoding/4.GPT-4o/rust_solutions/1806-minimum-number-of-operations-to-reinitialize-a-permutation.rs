impl Solution {
    pub fn reinitialize_permutation(n: i32) -> i32 {
        let mut perm = (0..n).collect::<Vec<_>>();
        let mut target = (0..n).collect::<Vec<_>>();
        let mut count = 0;

        loop {
            let mut new_perm = vec![0; n as usize];
            for i in 0..n {
                if i % 2 == 0 {
                    new_perm[i as usize] = perm[(i / 2) as usize];
                } else {
                    new_perm[i as usize] = perm[((n - 1) / 2 + i / 2) as usize];
                }
            }
            count += 1;
            perm = new_perm;

            if perm == target {
                break;
            }
        }

        count
    }
}