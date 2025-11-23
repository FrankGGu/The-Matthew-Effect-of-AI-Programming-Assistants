pub fn max_power(n: i32, stations: Vec<i32>, radius: i32) -> i32 {
    let (mut left, mut right) = (1, 1_000_000_000);

    while left < right {
        let mid = (left + right + 1) / 2;
        if can_power(mid, n, &stations, radius) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    left
}

fn can_power(target: i32, n: i32, stations: &Vec<i32>, radius: i32) -> bool {
    let mut coverage = vec![0; n as usize + 1];

    for &station in stations {
        let left = (station - radius).max(0) as usize;
        let right = (station + radius).min(n - 1) as usize;
        coverage[left] += 1;
        if right + 1 < coverage.len() {
            coverage[right + 1] -= 1;
        }
    }

    let mut current_power = 0;
    for i in 0..n as usize {
        current_power += coverage[i];
        if current_power < target {
            return false;
        }
    }

    true
}