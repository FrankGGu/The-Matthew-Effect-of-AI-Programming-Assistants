impl Solution {
    pub fn number_of_alternating_groups(colors: Vec<i32>) -> i32 {
        let n = colors.len();
        let mut count = 0;

        for i in 0..n {
            let c1 = colors[i];
            let c2 = colors[(i + 1) % n];
            let c3 = colors[(i + 2) % n];

            if c1 != c2 && c2 != c3 {
                count += 1;
            }
        }

        count
    }
}