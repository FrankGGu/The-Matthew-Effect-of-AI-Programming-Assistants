impl Solution {
    pub fn min_domino_rotations(a: Vec<i32>, b: Vec<i32>) -> i32 {
        let n = a.len();

        fn check(x: i32, a_ref: &[i32], b_ref: &[i32], n: usize) -> i32 {
            let mut rotations_a = 0;
            let mut rotations_b = 0;

            for i in 0..n {
                if a_ref[i] != x && b_ref[i] != x {
                    return -1;
                }
                if a_ref[i] != x {
                    rotations_a += 1;
                }
                if b_ref[i] != x {
                    rotations_b += 1;
                }
            }
            rotations_a.min(rotations_b)
        }

        let mut ans = -1;

        let res_a0 = check(a[0], &a, &b, n);
        if res_a0 != -1 {
            ans = res_a0;
        }

        if b[0] != a[0] {
            let res_b0 = check(b[0], &a, &b, n);
            if res_b0 != -1 {
                if ans == -1 || res_b0 < ans {
                    ans = res_b0;
                }
            }
        }

        ans
    }
}