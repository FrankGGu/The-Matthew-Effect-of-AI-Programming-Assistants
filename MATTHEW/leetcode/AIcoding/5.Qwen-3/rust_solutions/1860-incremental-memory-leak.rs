struct Solution;

impl Solution {
    pub fn memory_leak(a: i32, b: i32) -> Vec<i32> {
        let mut a = a;
        let mut b = b;
        let mut time = 0;

        while a > 0 || b > 0 {
            time += 1;
            if a >= b {
                a -= time;
            } else {
                b -= time;
            }
        }

        vec![time, a, b]
    }
}