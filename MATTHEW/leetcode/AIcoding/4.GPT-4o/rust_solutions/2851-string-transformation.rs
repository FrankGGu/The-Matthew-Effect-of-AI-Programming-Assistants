pub fn can_transform(start: String, end: String) -> bool {
    if start.chars().filter(|&c| c != 'X').collect::<String>() != end.chars().filter(|&c| c != 'X').collect::<String>() {
        return false;
    }

    let (mut i, mut j) = (0, 0);
    let n = start.len();

    while i < n || j < n {
        while i < n && start.chars().nth(i).unwrap() == 'X' {
            i += 1;
        }
        while j < n && end.chars().nth(j).unwrap() == 'X' {
            j += 1;
        }

        if i < n && j < n {
            if start.chars().nth(i) != end.chars().nth(j) {
                return false;
            }
            if start.chars().nth(i) == 'L' && i < j {
                return false;
            }
            if start.chars().nth(i) == 'R' && i > j {
                return false;
            }
            i += 1;
            j += 1;
        } else {
            break;
        }
    }

    true
}