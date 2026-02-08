pub fn kth_smallest_prime_fraction(arr: Vec<i32>, k: i32) -> Vec<i32> {
    use std::cmp::Ordering;

    let n = arr.len();
    let mut left = 0.0;
    let mut right = 1.0;

    for _ in 0..100 {
        let mid = (left + right) / 2.0;
        let mut count = 0;
        let mut max_fraction = 0.0;
        let mut max_pair = vec![0, 1];

        let mut j = n - 1;
        for i in 0..n {
            while j > 0 && arr[i] as f64 / arr[j - 1] as f64 > mid {
                j -= 1;
            }

            count += j;
            if j > 0 {
                let fraction = arr[i] as f64 / arr[j - 1] as f64;
                if fraction > max_fraction {
                    max_fraction = fraction;
                    max_pair = vec![arr[i], arr[j - 1]];
                }
            }
        }

        if count < k {
            left = mid;
        } else {
            right = mid;
        }
    }

    max_pair
}