pub fn min_number_of_frogs(croak_of_frogs: String) -> i32 {
    let mut croak_count = vec![0; 5];
    let mut frogs = 0;
    let mut max_frogs = 0;

    for c in croak_of_frogs.chars() {
        match c {
            'c' => {
                croak_count[0] += 1;
                frogs += 1;
                max_frogs = max_frogs.max(frogs);
            }
            'r' => {
                if croak_count[0] == 0 {
                    return -1;
                }
                croak_count[0] -= 1;
                croak_count[1] += 1;
            }
            'o' => {
                if croak_count[1] == 0 {
                    return -1;
                }
                croak_count[1] -= 1;
                croak_count[2] += 1;
            }
            'a' => {
                if croak_count[2] == 0 {
                    return -1;
                }
                croak_count[2] -= 1;
                croak_count[3] += 1;
            }
            'k' => {
                if croak_count[3] == 0 {
                    return -1;
                }
                croak_count[3] -= 1;
                frogs -= 1;
            }
            _ => return -1,
        }
    }

    if croak_count.iter().any(|&x| x > 0) {
        return -1;
    }

    max_frogs
}