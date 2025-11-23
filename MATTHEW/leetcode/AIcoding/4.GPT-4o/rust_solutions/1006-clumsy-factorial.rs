impl Solution {
    pub fn clumsy(n: i32) -> i32 {
        if n == 0 { return 0; }
        if n == 1 { return 1; }
        if n == 2 { return 2; }
        if n == 3 { return 6; }

        let mut result = 0;
        let mut current = n;

        while current > 0 {
            result += match current {
                n if n >= 4 => current * (current - 1) / (current - 2) + (current - 3),
                3 => 6,
                2 => 2,
                1 => 1,
                _ => 0,
            };
            current -= 4;
        }

        result
    }
}