fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}

impl Solution {
    pub fn fraction(cont: Vec<i32>) -> Vec<i32> {
        let mut a = 1;
        let mut b = cont[cont.len() - 1];

        for i in (0..cont.len() - 1).rev() {
            let temp = b;
            b = cont[i] * b + a;
            a = temp;
        }

        let common = gcd(a, b);
        vec![b / common, a / common]
    }
}