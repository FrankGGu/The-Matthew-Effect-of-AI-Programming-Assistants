impl Solution {
    pub fn mem_leak(memory1: i32, memory2: i32) -> Vec<i32> {
        let mut m1 = memory1 as i64;
        let mut m2 = memory2 as i64;
        let mut i = 1;
        while m1 >= i || m2 >= i {
            if m1 >= m2 {
                m1 -= i;
            } else {
                m2 -= i;
            }
            i += 1;
        }
        vec![i as i32, m1 as i32, m2 as i32]
    }
}