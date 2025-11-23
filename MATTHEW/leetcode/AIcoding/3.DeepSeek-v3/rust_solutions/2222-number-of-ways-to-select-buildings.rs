impl Solution {
    pub fn number_of_ways(s: String) -> i64 {
        let s = s.as_bytes();
        let mut count0 = 0;
        let mut count1 = 0;
        let mut count01 = 0;
        let mut count10 = 0;
        let mut res = 0;

        for &c in s {
            if c == b'0' {
                count0 += 1;
                count10 += count1;
                res += count01;
            } else {
                count1 += 1;
                count01 += count0;
                res += count10;
            }
        }

        res
    }
}