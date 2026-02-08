impl Solution {
    pub fn minimum_time(locks: Vec<i32>, first: i32, key: i32) -> i32 {
        let mut locks = locks;
        locks.sort();
        let mut time = 0;
        let mut current = first;
        for &lock in &locks {
            let diff1 = (lock - current).abs();
            let diff2 = 360 - diff1;
            time += diff1.min(diff2);
            current = lock;
        }
        let diff1 = (key - current).abs();
        let diff2 = 360 - diff1;
        time += diff1.min(diff2);
        time
    }
}