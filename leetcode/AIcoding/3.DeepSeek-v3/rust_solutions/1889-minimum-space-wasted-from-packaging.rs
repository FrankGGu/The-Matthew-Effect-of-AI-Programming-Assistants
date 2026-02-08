impl Solution {
    pub fn min_wasted_space(packages: Vec<i32>, boxes: Vec<Vec<i32>>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let n = packages.len();
        let mut packages = packages;
        packages.sort_unstable();
        let prefix_sum: Vec<i64> = packages
            .iter()
            .scan(0, |sum, &x| {
                *sum += x as i64;
                Some(*sum)
            })
            .collect();

        let mut min_waste = i64::MAX;
        for mut box_sizes in boxes {
            box_sizes.sort_unstable();
            if *box_sizes.last().unwrap() < *packages.last().unwrap() {
                continue;
            }

            let mut total = 0;
            let mut prev = 0;
            for &box_size in &box_sizes {
                let idx = match packages.binary_search(&box_size) {
                    Ok(i) => i + 1,
                    Err(i) => i,
                };
                if idx > prev {
                    let sum = prefix_sum[idx - 1] - if prev == 0 { 0 } else { prefix_sum[prev - 1] };
                    let count = (idx - prev) as i64;
                    total += box_size as i64 * count - sum;
                    prev = idx;
                }
                if prev >= n {
                    break;
                }
            }

            if prev == n {
                min_waste = min_waste.min(total);
            }
        }

        if min_waste == i64::MAX {
            -1
        } else {
            (min_waste % MOD) as i32
        }
    }
}