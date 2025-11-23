impl Solution {
    pub fn nth_ugly_number(n: i32) -> i32 {
        let mut ugly_numbers: Vec<i32> = vec![1];
        let mut p2 = 0;
        let mut p3 = 0;
        let mut p5 = 0;

        while ugly_numbers.len() < n as usize {
            let next_ugly = std::cmp::min(ugly_numbers[p2] * 2, std::cmp::min(ugly_numbers[p3] * 3, ugly_numbers[p5] * 5));
            ugly_numbers.push(next_ugly);

            if next_ugly == ugly_numbers[p2] * 2 {
                p2 += 1;
            }
            if next_ugly == ugly_numbers[p3] * 3 {
                p3 += 1;
            }
            if next_ugly == ugly_numbers[p5] * 5 {
                p5 += 1;
            }
        }

        *ugly_numbers.last().unwrap()
    }
}