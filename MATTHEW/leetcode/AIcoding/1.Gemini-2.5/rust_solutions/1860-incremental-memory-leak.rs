impl Solution {
    pub fn mem_leak(memory1: i32, memory2: i32) -> Vec<i32> {
        let mut m1 = memory1;
        let mut m2 = memory2;
        let mut i = 1;

        loop {
            if m1 >= m2 {
                if m1 < i {
                    break;
                }
                m1 -= i;
            } else {
                if m2 < i {
                    break;
                }
                m2 -= i;
            }
            i += 1;
        }

        vec![i, m1, m2]
    }
}