pub fn kth_smallest_path(destination: Vec<i32>, k: i32) -> String {
    let (m, n) = (destination[0], destination[1]);
    let mut path = String::new();
    let mut k = k - 1; // Convert to 0-based index
    let mut remaining_steps = m + n;

    for _ in 0..remaining_steps {
        if m == 0 {
            path.push('H');
            n -= 1;
        } else if n == 0 {
            path.push('V');
            m -= 1;
        } else {
            let total_paths = combination(m + n - 1, n - 1);
            if k < total_paths {
                path.push('V');
                m -= 1;
            } else {
                path.push('H');
                n -= 1;
                k -= total_paths;
            }
        }
    }

    path
}

fn combination(n: i32, k: i32) -> i32 {
    if k == 0 || n == k {
        return 1;
    }
    let mut num = 1;
    let mut denom = 1;
    for i in 0..k {
        num *= n - i;
        denom *= i + 1;
    }
    num / denom
}