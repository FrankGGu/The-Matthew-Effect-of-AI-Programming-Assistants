impl Solution {
    pub fn min_transfers(apples: Vec<i32>, boxes: Vec<i32>) -> i32 {
        let n = apples.len();
        let mut diff = vec![0; n];
        for i in 0..n {
            diff[i] = apples[i] - boxes[i];
        }

        let mut ans = std::i32::MAX;

        fn solve(diff: &mut Vec<i32>, count: i32) -> i32 {
            let mut i = 0;
            while i < diff.len() && diff[i] == 0 {
                i += 1;
            }

            if i == diff.len() {
                return count;
            }

            let mut res = std::i32::MAX;
            for j in i + 1..diff.len() {
                if diff[i] * diff[j] < 0 {
                    let transfer = std::cmp::min(diff[i].abs(), diff[j].abs());
                    diff[i] += if diff[i] > 0 { -transfer } else { transfer };
                    diff[j] += if diff[j] > 0 { -transfer } else { transfer };
                    res = std::cmp::min(res, solve(diff, count + 1));
                     diff[i] -= if diff[i] > 0 { -transfer } else { transfer };
                    diff[j] -= if diff[j] > 0 { -transfer } else { transfer };
                }
            }
            res
        }

        ans = solve(&mut diff, 0);
        ans
    }
}