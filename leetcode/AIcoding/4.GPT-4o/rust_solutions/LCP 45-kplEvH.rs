pub fn max_points(points: Vec<Vec<i32>>) -> i32 {
    let n = points.len();
    if n <= 2 {
        return n as i32;
    }

    let mut max_points = 2;

    for i in 0..n {
        let mut slope_count = std::collections::HashMap::new();
        let mut duplicates = 1;

        for j in 0..n {
            if i == j {
                continue;
            }
            if points[i] == points[j] {
                duplicates += 1;
                continue;
            }
            let dx = points[j][0] - points[i][0];
            let dy = points[j][1] - points[i][1];
            let gcd = gcd(dx, dy);
            let slope = (dy / gcd, dx / gcd);
            *slope_count.entry(slope).or_insert(0) += 1;
        }

        let current_max = slope_count.values().max().unwrap_or(&0) + duplicates;
        max_points = max_points.max(current_max);
    }

    max_points
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a.abs()
    } else {
        gcd(b, a % b)
    }
}