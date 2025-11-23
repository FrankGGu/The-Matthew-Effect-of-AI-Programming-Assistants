impl Solution {
    pub fn are_similar(a: Vec<Vec<i32>>, b: Vec<Vec<i32>>) -> bool {
        let n = a.len();
        let mut a_sorted = a.iter().flat_map(|x| x.iter()).collect::<Vec<_>>();
        let mut b_sorted = b.iter().flat_map(|x| x.iter()).collect::<Vec<_>>();
        a_sorted.sort();
        b_sorted.sort();
        if a_sorted != b_sorted {
            return false;
        }

        let mut a_diff = Vec::new();
        let mut b_diff = Vec::new();

        for i in 0..n {
            for j in 0..n {
                if a[i][j] != b[i][j] {
                    a_diff.push(a[i][j]);
                    b_diff.push(b[i][j]);
                }
            }
        }

        if a_diff.len() > 2 {
            return false;
        }

        if a_diff.len() == 2 {
            return (a_diff[0] == b_diff[1]) && (a_diff[1] == b_diff[0]);
        }

        true
    }
}