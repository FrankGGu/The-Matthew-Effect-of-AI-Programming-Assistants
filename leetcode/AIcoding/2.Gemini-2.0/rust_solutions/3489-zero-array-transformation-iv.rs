impl Solution {
    pub fn solve(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut a = nums.clone();
        let mut ans = 0;

        while a.iter().any(|&x| x != 0) {
            ans += 1;
            let mut b = vec![0; n];
            for i in 0..n {
                if a[i] != 0 {
                    let mut j = (i + 1) % n;
                    while j != i {
                        if a[j] == 0 {
                            b[j] = a[i];
                            a[i] = 0;
                            break;
                        }
                        j = (j + 1) % n;
                    }
                    if j == i {
                      a[i] = 0;
                    }
                }
            }
            for i in 0..n {
                a[i] = a[i] ^ b[i];
            }
        }

        ans
    }
}