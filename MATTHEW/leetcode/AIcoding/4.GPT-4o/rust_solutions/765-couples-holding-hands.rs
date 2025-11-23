impl Solution {
    pub fn min_swaps(couples: Vec<i32>) -> i32 {
        let n = couples.len() / 2;
        let mut pos = vec![0; n];
        for (i, &c) in couples.iter().enumerate() {
            pos[c / 2] = i;
        }

        let mut visited = vec![false; n];
        let mut swaps = 0;

        for i in 0..n {
            if visited[i] || couples[i * 2] / 2 == i {
                continue;
            }

            let mut cycle_size = 0;
            let mut j = i;

            while !visited[j] {
                visited[j] = true;
                j = pos[couples[j * 2] / 2];
                cycle_size += 1;
            }

            if cycle_size > 0 {
                swaps += cycle_size - 1;
            }
        }

        swaps
    }
}