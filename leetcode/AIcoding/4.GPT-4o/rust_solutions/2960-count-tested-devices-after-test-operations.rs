pub fn count_devices_after_tests(n: i32, operations: Vec<i32>) -> i32 {
    let mut devices = vec![true; n as usize];

    for op in operations {
        if op > 0 {
            devices[(op - 1) as usize] = false;
        } else {
            devices[(-op - 1) as usize] = true;
        }
    }

    devices.iter().filter(|&&x| x).count() as i32
}