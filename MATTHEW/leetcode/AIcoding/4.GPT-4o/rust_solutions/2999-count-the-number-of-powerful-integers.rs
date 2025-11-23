impl Solution {
    pub fn powerful_integers(x: i32, y: i32, bound: i32) -> Vec<i32> {
        let mut powerful_integers = std::collections::HashSet::new();
        let mut a = 1;

        for i in 0.. {
            if a > bound { break; }
            let mut b = 1;
            for j in 0.. {
                let sum = a + b;
                if sum > bound { break; }
                powerful_integers.insert(sum);
                if y == 1 { break; }
                b *= y;
            }
            if x == 1 { break; }
            a *= x;
        }

        powerful_integers.into_iter().collect()
    }
}