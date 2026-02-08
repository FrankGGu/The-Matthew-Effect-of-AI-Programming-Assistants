impl Solution {
    pub fn min_perimeter(n: i32) -> i64 {
        let mut res = i64::MAX;
        let mut count = 0;

        for width in 1..=n {
            if n % width == 0 {
                let height = n / width;
                let perimeter = 2 * (width + height);
                res = res.min(perimeter);
                count += 1;
            }
        }

        res
    }
}