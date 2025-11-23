impl Solution {
    pub fn max_building(n: i32, restrictions: Vec<Vec<i32>>) -> i32 {
        let mut restrictions = restrictions;
        restrictions.push(vec![0, 0]);
        restrictions.push(vec![n, n]);
        restrictions.sort();

        let mut max_height = 0;

        for i in 0..restrictions.len() - 1 {
            let (x1, h1) = (restrictions[i][0], restrictions[i][1]);
            let (x2, h2) = (restrictions[i + 1][0], restrictions[i + 1][1]);
            max_height = max_height.max((h1 + h2 + (x2 - x1)) / 2);
            let height = h1 + (x2 - x1);
            max_height = max_height.max(height);
            max_height = max_height.max(h2 + (x1 - x2));
        }

        max_height
    }
}