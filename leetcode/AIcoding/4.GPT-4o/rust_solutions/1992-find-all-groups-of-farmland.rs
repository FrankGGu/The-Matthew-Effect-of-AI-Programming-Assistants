struct Solution;

impl Solution {
    pub fn find_farmland(land: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let rows = land.len();
        let cols = land[0].len();

        for i in 0..rows {
            for j in 0..cols {
                if land[i][j] == 1 {
                    let mut r1 = i;
                    let mut c1 = j;
                    while r1 < rows && land[r1][j] == 1 {
                        r1 += 1;
                    }
                    while c1 < cols && land[i][c1] == 1 {
                        c1 += 1;
                    }
                    result.push(vec![i as i32, j as i32, (r1 - 1) as i32, (c1 - 1) as i32]);
                    for x in i..r1 {
                        for y in j..c1 {
                            land[x][y] = 0;
                        }
                    }
                }
            }
        }

        result
    }
}