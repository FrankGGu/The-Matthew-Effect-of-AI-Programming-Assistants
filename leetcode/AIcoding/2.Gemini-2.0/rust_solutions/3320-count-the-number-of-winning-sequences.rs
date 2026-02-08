impl Solution {
    pub fn number_of_sequences(n: i32, mut sick: Vec<i32>) -> i32 {
        sick.sort();
        let mut dp = std::collections::HashMap::new();

        fn solve(n: i32, sick: &Vec<i32>, mask: i32, dp: &mut std::collections::HashMap<(i32, i32), i32>) -> i32 {
            if mask == (1 << n) - 1 {
                return 1;
            }

            if let Some(&val) = dp.get(&(n, mask)) {
                return val;
            }

            let mut ans = 0;
            for i in 0..n {
                if (mask & (1 << i)) == 0 {
                    let mut valid = true;
                    for &s in sick {
                        if s == i + 1 {
                            valid = false;
                            break;
                        }
                    }

                    if valid {
                        ans = (ans + solve(n, sick, mask | (1 << i), dp)) % 1000000007;
                    }
                }
            }

            dp.insert((n, mask), ans);
            ans
        }

        solve(n, &sick, 0, &mut dp)
    }
}