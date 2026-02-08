impl Solution {
    pub fn minimum_swaps(s: String, t: String) -> i32 {
        let n = s.len();
        let (mut xy, mut yx) = (0, 0);

        for (cs, ct) in s.chars().zip(t.chars()) {
            if cs != ct {
                if cs == 'x' {
                    xy += 1;
                } else {
                    yx += 1;
                }
            }
        }

        if (xy + yx) % 2 != 0 {
            return -1;
        }

        xy / 2 + yx / 2 + xy % 2
    }
}