impl Solution {
    pub fn max_happy_groups(batch_size: i32, groups: Vec<i32>) -> i32 {
        let n = batch_size as usize;
        let mut counts = vec![0; n];
        let mut happy = 0;
        for &g in &groups {
            let rem = (g % batch_size) as usize;
            if rem == 0 {
                happy += 1;
            } else {
                counts[rem] += 1;
            }
        }

        let mut memo = std::collections::HashMap::new();

        fn solve(counts: &Vec<i32>, n: usize, memo: &mut std::collections::HashMap<Vec<i32>, i32>) -> i32 {
            if counts.iter().all(|&c| c == 0) {
                return 0;
            }

            if let Some(&res) = memo.get(counts) {
                return res;
            }

            let mut max_happy = 0;
            for start in 1..n {
                if counts[start] > 0 {
                    let mut next_counts = counts.clone();
                    next_counts[start] -= 1;
                    let happy = if next_counts.iter().all(|&c| c == 0) {
                        1
                    } else {
                        let mut sum = 0;
                        for i in 1..n {
                            sum += (i as i32) * counts[i];
                        }
                        sum %= n as i32;

                        if (n as i32 - start as i32) % (n as i32) == sum  {
                            1
                        } else {
                            0
                        }
                    };

                    max_happy = max_happy.max(happy + solve(&next_counts, n, memo));
                }
            }
            memo.insert(counts.clone(), max_happy);
            max_happy
        }

        happy + solve(&counts, n, &mut memo)
    }
}