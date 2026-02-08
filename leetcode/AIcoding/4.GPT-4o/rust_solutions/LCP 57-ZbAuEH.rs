pub fn num_of_moles(mut m: Vec<i32>, k: i32) -> i32 {
    let mut count = 0;
    let mut sum = 0;
    let n = m.len();

    for i in 0..n {
        sum += m[i];
    }

    if sum < k {
        return 0;
    }

    for i in 0..n {
        if m[i] > 0 {
            count += 1;
            sum -= m[i];
            if sum < k {
                break;
            }
        }
    }

    count
}