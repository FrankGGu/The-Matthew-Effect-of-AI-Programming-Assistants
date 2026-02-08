pub fn max_removable_characters(s: String, p: String, removable: Vec<i32>) -> i32 {
    let (mut left, mut right) = (0, removable.len() as i32);

    while left < right {
        let mid = left + (right - left + 1) / 2;
        if can_form(&s, &p, &removable, mid) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    left
}

fn can_form(s: &str, p: &str, removable: &[i32], k: i32) -> bool {
    let mut removed = vec![false; s.len()];
    for i in 0..k {
        removed[removable[i as usize] as usize] = true;
    }

    let mut j = 0;
    for i in 0..s.len() {
        if !removed[i] && j < p.len() && s.as_bytes()[i] == p.as_bytes()[j] {
            j += 1;
        }
    }
    j == p.len()
}