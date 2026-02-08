pub fn can_transform(nums: Vec<i32>) -> bool {
    let mut pos = vec![];
    let mut neg = vec![];

    for &num in &nums {
        if num > 0 {
            pos.push(num);
        } else if num < 0 {
            neg.push(num);
        }
    }

    pos.sort();
    neg.sort_by(|a, b| b.cmp(a));

    for i in 1..pos.len() {
        if pos[i] != pos[i - 1] {
            return false;
        }
    }

    for i in 1..neg.len() {
        if neg[i] != neg[i - 1] {
            return false;
        }
    }

    true
}