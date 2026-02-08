impl Solution {
    pub fn monotone_increasing_digits(n: i32) -> i32 {
        let mut s: Vec<char> = n.to_string().chars().collect();
        let len = s.len();
        let mut mark = len;

        for i in (1..len).rev() {
            if s[i] < s[i - 1] {
                s[i - 1] = ((s[i - 1] as u8) - 1) as char;
                mark = i;
            }
        }

        for i in mark..len {
            s[i] = '9';
        }

        s.iter().collect::<String>().parse::<i32>().unwrap()
    }
}