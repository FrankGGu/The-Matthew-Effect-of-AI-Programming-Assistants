pub fn longest_happy_string(a: i32, b: i32, c: i32) -> String {
    let mut result = String::new();
    let mut a = a;
    let mut b = b;
    let mut c = c;

    while a > 0 || b > 0 || c > 0 {
        let mut added = false;
        if a >= b && a >= c && (result.len() < 2 || !result.ends_with("aaa")) {
            result.push('a');
            a -= 1;
            added = true;
        } else if b >= a && b >= c && (result.len() < 2 || !result.ends_with("bbb")) {
            result.push('b');
            b -= 1;
            added = true;
        } else if c >= a && c >= b && (result.len() < 2 || !result.ends_with("ccc")) {
            result.push('c');
            c -= 1;
            added = true;
        }
        if !added {
            break;
        }
    }

    result
}