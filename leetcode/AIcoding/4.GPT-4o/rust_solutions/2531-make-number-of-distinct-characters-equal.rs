impl Solution {
    pub fn can_make_equal(s: String, t: String) -> bool {
        let mut count_s = [0; 26];
        let mut count_t = [0; 26];

        for c in s.chars() {
            count_s[(c as usize - 'a' as usize)] += 1;
        }

        for c in t.chars() {
            count_t[(c as usize - 'a' as usize)] += 1;
        }

        let mut distinct_s = 0;
        let mut distinct_t = 0;

        for i in 0..26 {
            if count_s[i] > 0 {
                distinct_s += 1;
            }
            if count_t[i] > 0 {
                distinct_t += 1;
            }
        }

        distinct_s == distinct_t
    }
}