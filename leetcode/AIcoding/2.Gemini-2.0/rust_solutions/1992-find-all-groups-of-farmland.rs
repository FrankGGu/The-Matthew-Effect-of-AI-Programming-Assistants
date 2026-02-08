impl Solution {
    pub fn find_farmland(land: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = land.len();
        let n = land[0].len();
        let mut result = Vec::new();

        for r1 in 0..m {
            for c1 in 0..n {
                if land[r1][c1] == 1 {
                    let mut r2 = r1;
                    while r2 + 1 < m && land[r2 + 1][c1] == 1 {
                        r2 += 1;
                    }

                    let mut c2 = c1;
                    while c2 + 1 < n && land[r1][c2 + 1] == 1 {
                        c2 += 1;
                    }

                    let mut valid = true;
                    for i in r1..=r2 {
                        for j in c1..=c2 {
                            if land[i][j] == 0 {
                                valid = false;
                                break;
                            }
                        }
                        if !valid {
                            break;
                        }
                    }

                    if valid {
                        result.push(vec![r1 as i32, c1 as i32, r2 as i32, c2 as i32]);
                        for i in r1..=r2 {
                            for j in c1..=c2 {
                                land[i][j] = 0;
                            }
                        }
                    }
                }
            }
        }

        result
    }
}