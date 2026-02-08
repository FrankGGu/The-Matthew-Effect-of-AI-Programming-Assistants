impl Solution {
    pub fn find_solution(customfunction: &CustomFunction, z: i32) -> Vec<Vec<i32>> {
        let mut res = Vec::new();
        let mut x = 1;
        let mut y = 1000;

        while x <= 1000 && y >= 1 {
            let val = customfunction.f(x, y);
            if val == z {
                res.push(vec![x, y]);
                x += 1;
                y -= 1;
            } else if val < z {
                x += 1;
            } else {
                y -= 1;
            }
        }

        res
    }
}