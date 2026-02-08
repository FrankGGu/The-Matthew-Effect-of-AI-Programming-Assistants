pub fn training_plan(n: i32, gain: Vec<i32>, loss: Vec<i32>) -> i32 {
    let mut max_gain = 0;
    let mut current_gain = 0;

    for i in 0..n as usize {
        current_gain += gain[i] - loss[i];
        if current_gain < 0 {
            current_gain = 0;
        }
        max_gain = max_gain.max(current_gain);
    }

    max_gain
}