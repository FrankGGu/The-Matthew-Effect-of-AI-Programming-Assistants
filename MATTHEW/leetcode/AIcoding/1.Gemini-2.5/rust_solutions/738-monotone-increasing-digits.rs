impl Solution {
    pub fn monotone_increasing_digits(n: i32) -> i32 {
        let mut s = n.to_string().chars().map(|c| c.to_digit(10).unwrap() as u8).collect::<Vec<u8>>();
        let len = s.len();
        let mut marker = len;

        for i in (0..len - 1).rev() {
            if s[i] > s[i+1] {
                s[i] -= 1;
                marker = i + 1;
            }
        }

        for i in marker..len {
            s[i] = 9;
        }

        let res_str: String = s.iter().map(|&d| (d + b'0') as char).collect();
        res_str.parse::<i32>().unwrap()
    }
}