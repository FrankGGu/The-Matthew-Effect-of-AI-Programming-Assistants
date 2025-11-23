impl Solution {
    pub fn mem_leak(memory1: i32, memory2: i32) -> Vec<i32> {
        let mut memory1 = memory1;
        let mut memory2 = memory2;
        let mut time = 1;

        loop {
            if memory1 >= memory2 {
                if memory1 < time {
                    break;
                }
                memory1 -= time;
            } else {
                if memory2 < time {
                    break;
                }
                memory2 -= time;
            }
            time += 1;
        }

        vec![time, memory1, memory2]
    }
}