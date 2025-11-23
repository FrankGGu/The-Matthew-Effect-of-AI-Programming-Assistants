impl Solution {
    pub fn min_number_of_frogs(croak_of_frogs: String) -> i32 {
        let mut c = 0;
        let mut r = 0;
        let mut o = 0;
        let mut a = 0;
        let mut k = 0;
        let mut frogs = 0;
        let mut max_frogs = 0;

        for ch in croak_of_frogs.chars() {
            match ch {
                'c' => {
                    c += 1;
                    frogs += 1;
                    max_frogs = max_frogs.max(frogs);
                }
                'r' => {
                    r += 1;
                    if c == 0 {
                        return -1;
                    }
                    c -= 1;
                }
                'o' => {
                    o += 1;
                    if r == 0 {
                        return -1;
                    }
                    r -= 1;
                }
                'a' => {
                    a += 1;
                    if o == 0 {
                        return -1;
                    }
                    o -= 1;
                }
                'k' => {
                    k += 1;
                    if a == 0 {
                        return -1;
                    }
                    a -= 1;
                    frogs -= 1;
                }
                _ => return -1,
            }
        }

        if c != 0 || r != 0 || o != 0 || a != 0 || k != 0 {
            return -1;
        }

        max_frogs
    }
}