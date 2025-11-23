impl Solution {
    pub fn num_of_ways(n: i32) -> i32 {
        let mut color3: i64 = 6;
        let mut color2: i64 = 6;
        let modulo: i64 = 1_000_000_007;

        for _ in 1..n {
            let new_color3 = (2 * color3 + 2 * color2) % modulo;
            let new_color2 = (2 * color3 + 3 * color2) % modulo;
            color3 = new_color3;
            color2 = new_color2;
        }

        ((color3 + color2) % modulo) as i32
    }
}