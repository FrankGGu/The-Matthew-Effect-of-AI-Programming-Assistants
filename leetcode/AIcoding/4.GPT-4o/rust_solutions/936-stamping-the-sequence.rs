pub fn moves_to_stamp(stamp: String, target: String) -> Vec<i32> {
    let m = stamp.len();
    let n = target.len();
    let mut target_chars: Vec<_> = target.chars().collect();
    let mut stamp_chars: Vec<_> = stamp.chars().collect();
    let mut visited = vec![false; n];
    let mut result = vec![];
    let mut count = 0;

    fn can_stamp(stamp: &Vec<char>, target: &Vec<char>, i: usize) -> bool {
        let mut can_stamp = false;
        for j in 0..stamp.len() {
            if i + j < target.len() {
                if target[i + j] == '?' {
                    continue;
                }
                if target[i + j] != stamp[j] {
                    return false;
                }
            }
        }
        true
    }

    fn do_stamp(stamp: &Vec<char>, target: &mut Vec<char>, i: usize) {
        for j in 0..stamp.len() {
            if i + j < target.len() {
                target[i + j] = '?';
            }
        }
    }

    loop {
        let mut stamped = false;
        for i in 0..=n - m {
            if !visited[i] && can_stamp(&stamp_chars, &target_chars, i) {
                do_stamp(&stamp_chars, &mut target_chars, i);
                visited[i] = true;
                result.push(i as i32);
                stamped = true;
                count += 1;
            }
        }
        if !stamped {
            break;
        }
    }

    if target_chars.iter().all(|&c| c == '?') {
        result.reverse();
        return result;
    }

    vec![]
}