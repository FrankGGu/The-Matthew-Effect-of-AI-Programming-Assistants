impl Solution {
    pub fn powerful_integers(x: i32, y: i32, bound: i32) -> Vec<i32> {
        let mut result = std::collections::HashSet::new();
        let mut a = 1;
        while a < bound {
            let mut b = 1;
            while a + b <= bound {
                result.insert(a + b);
                if y == 1 { break; }
                b *= y;
            }
            if x == 1 { break; }
            a *= x;
        }
        result.into_iter().collect()
    }
}