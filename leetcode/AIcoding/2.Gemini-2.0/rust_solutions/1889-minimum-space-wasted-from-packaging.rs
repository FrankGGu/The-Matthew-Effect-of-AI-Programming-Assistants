impl Solution {
    pub fn min_space_wasted_kmp(packages: Vec<i32>, boxes: Vec<Vec<i32>>) -> i32 {
        let MOD = 1_000_000_007;
        let mut packages = packages;
        packages.sort();
        let n = packages.len();
        let mut ans = -1i64;

        for box_arr in boxes {
            let mut box_arr = box_arr;
            box_arr.sort();
            if box_arr[box_arr.len() - 1] < packages[n - 1] {
                continue;
            }

            let mut cur = 0i64;
            let mut prev = 0;
            for &p in &packages {
                let mut l = prev;
                let mut r = box_arr.len() as i32 - 1;
                let mut best = -1;
                while l <= r {
                    let mid = l + (r - l) / 2;
                    if box_arr[mid as usize] >= p {
                        best = mid;
                        r = mid - 1;
                    } else {
                        l = mid + 1;
                    }
                }

                if best == -1 {
                    cur = -1;
                    break;
                }

                let b_idx = best as usize;
                cur += box_arr[b_idx] as i64 - p as i64;
                prev = b_idx as i32;
            }

            if cur != -1 {
                if ans == -1 || cur < ans {
                    ans = cur;
                }
            }
        }

        if ans == -1 {
            0
        } else {
            (ans % MOD as i64) as i32
        }
    }
}