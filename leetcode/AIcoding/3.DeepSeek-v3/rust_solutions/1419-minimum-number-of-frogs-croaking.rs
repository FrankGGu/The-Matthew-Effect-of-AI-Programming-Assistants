impl Solution {
    pub fn min_number_of_frogs(croak_of_frogs: String) -> i32 {
        let mut count = [0; 5];
        let mut frogs = 0;
        let mut max_frogs = 0;

        for c in croak_of_frogs.chars() {
            let idx = match c {
                'c' => 0,
                'r' => 1,
                'o' => 2,
                'a' => 3,
                'k' => 4,
                _ => return -1,
            };
            count[idx] += 1;

            if idx != 0 {
                if count[idx] > count[idx - 1] {
                    return -1;
                }
            }

            if idx == 4 {
                frogs -= 1;
            }

            if idx == 0 {
                frogs += 1;
                if frogs > max_frogs {
                    max_frogs = frogs;
                }
            }
        }

        if count[0] != count[4] {
            -1
        } else {
            max_frogs
        }
    }
}