impl Solution {
    pub fn min_number_of_frogs(croak: String) -> i32 {
        let mut c_count = 0;
        let mut r_count = 0;
        let mut o_count = 0;
        let mut a_count = 0;

        let mut active_frogs = 0;
        let mut max_frogs = 0;

        for ch in croak.chars() {
            match ch {
                'c' => {
                    c_count += 1;
                    active_frogs += 1;
                    max_frogs = max_frogs.max(active_frogs);
                },
                'r' => {
                    if c_count == 0 { return -1; }
                    c_count -= 1;
                    r_count += 1;
                },
                'o' => {
                    if r_count == 0 { return -1; }
                    r_count -= 1;
                    o_count += 1;
                },
                'a' => {
                    if o_count == 0 { return -1; }
                    o_count -= 1;
                    a_count += 1;
                },
                'k' => {
                    if a_count == 0 { return -1; }
                    a_count -= 1;
                    active_frogs -= 1;
                },
                _ => return -1,
            }
        }

        if active_frogs != 0 {
            return -1;
        }

        max_frogs
    }
}