impl Solution {
    pub fn maximum_swap(num: i32) -> i32 {
        let mut digits: Vec<i32> = num.to_string().chars().map(|d| d.to_digit(10).unwrap() as i32).collect();
        let mut last = [0; 10];

        for (i, &d) in digits.iter().enumerate() {
            last[d as usize] = i;
        }

        for (i, &d) in digits.iter().enumerate() {
            for x in (d + 1)..10 {
                if last[x as usize] > i {
                    digits.swap(i, last[x as usize]);
                    return digits.iter().fold(0, |acc, &d| acc * 10 + d) as i32;
                }
            }
        }

        num
    }
}