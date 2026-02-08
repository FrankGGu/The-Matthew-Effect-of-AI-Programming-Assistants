fn minimize_the_maximum_of_two_arrays(n: i32, divisor1: i32, divisor2: i32, unique_cnt1: i32, unique_cnt2: i32) -> i32 {
    let gcd = |a: i64, b: i64| -> i64 {
        let mut a = a;
        let mut b = b;
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    };

    let lcm = |a: i64, b: i64| -> i64 {
        a * b / gcd(a, b)
    };

    let mut left: i64 = 1;
    let mut right: i64 = n as i64 * 2;

    while left <= right {
        let mid = left + (right - left) / 2;

        let a = mid - mid / divisor1 as i64;
        let b = mid - mid / divisor2 as i64;
        let c = mid - mid / divisor1 as i64 - mid / divisor2 as i64 + mid / lcm(divisor1 as i64, divisor2 as i64);

        if a >= unique_cnt1 as i64 && b >= unique_cnt2 as i64 && c >= unique_cnt1 as i64 + unique_cnt2 as i64 {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    left as i32
}