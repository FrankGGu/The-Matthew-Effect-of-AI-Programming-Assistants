impl Solution {
    pub fn count_of_pairs(n: i32, x: i32, y: i32) -> Vec<i32> {
        let n = n as usize;
        let x = (x - 1) as usize;
        let y = (y - 1) as usize;
        let mut result = vec![0; n];

        for i in 0..n {
            for j in (i + 1)..n {
                let dist = (j - i).min((x.max(i).min(j) - x.min(i).max(x)).min((y.max(i).min(j) - y.min(i).max(y))) + 1 + (x - i).abs().min((y - i).abs()) + (x - j).abs().min((y - j).abs()).min((i as i32 - x as i32).abs().min((i as i32 - y as i32).abs()) + (j as i32 - x as i32).abs().min((j as i32 - y as i32).abs())) + (i as i32 - j as i32).abs().min(((x as i32 - i as i32).abs() + (y as i32 - j as i32).abs() + 1).min(((y as i32 - i as i32).abs() + (x as i32 - j as i32).abs() + 1)) as usize);

                let dist_direct = (j - i);
                let dist_through = (x.max(i).min(j) - x.min(i).max(x)) + (y - x).abs() + 1;

                let dist_through_two = (y.max(i).min(j) - y.min(i).max(y)) + (x - y).abs() + 1;

                let final_dist = (i as i32 - x as i32).abs().min((i as i32 - y as i32).abs()) + (j as i32 - x as i32).abs().min((j as i32 - y as i32).abs()) + 1 + (j as i32 - i as i32).abs();

                let actual_dist = dist_direct.min(((x as i32 - i as i32).abs() + (y as i32 - j as i32).abs() + 1).min(((y as i32 - i as i32).abs() + (x as i32 - j as i32).abs() + 1)) as usize);

                let shortest_dist = (j-i).min((x.abs_diff(i)+1+y.abs_diff(j)).min(y.abs_diff(i)+1+x.abs_diff(j)));
                result[shortest_dist - 1] += 2;
            }
        }

        result
    }
}