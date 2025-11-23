pub fn max_alloys(n: i32, m: i32, requirements: Vec<(i32, i32)>, available: Vec<i32>) -> i32 {
    let mut low = 0;
    let mut high = 1_000_000_000;

    while low < high {
        let mid = (low + high + 1) / 2;
        if can_make_alloys(n, m, &requirements, &available, mid) {
            low = mid;
        } else {
            high = mid - 1;
        }
    }
    low
}

fn can_make_alloys(n: i32, m: i32, requirements: &Vec<(i32, i32)>, available: &Vec<i32>, k: i32) -> bool {
    let mut need = vec![0; n as usize];

    for (i, &(a, b)) in requirements.iter().enumerate() {
        need[i] = a * k;
    }

    for i in 0..n as usize {
        if need[i] > available[i] {
            return false;
        }
    }

    true
}