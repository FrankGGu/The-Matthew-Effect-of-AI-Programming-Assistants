pub fn mirror_reflection(p: i32, q: i32) -> i32 {
    let gcd = |a: i32, b: i32| {
        let mut a = a;
        let mut b = b;
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    };

    let g = gcd(p, q);
    let m = q / g % 2;
    let n = p / g % 2;

    m * 2 + n
}