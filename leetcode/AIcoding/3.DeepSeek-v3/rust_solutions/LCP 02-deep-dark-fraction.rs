impl Solution {
    pub fn fraction(cont: Vec<i32>) -> Vec<i32> {
        let mut numerator = 1;
        let mut denominator = *cont.last().unwrap();

        for &num in cont.iter().rev().skip(1) {
            numerator += num * denominator;
            std::mem::swap(&mut numerator, &mut denominator);
        }

        std::mem::swap(&mut numerator, &mut denominator);
        vec![numerator, denominator]
    }
}