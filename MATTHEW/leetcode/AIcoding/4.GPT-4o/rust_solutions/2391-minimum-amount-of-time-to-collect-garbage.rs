impl Solution {
    pub fn garbage_collection(garbage: Vec<String>, travel: Vec<i32>) -> i32 {
        let mut total_time = 0;
        let mut last_garbage = vec![0; 3];

        for (i, g) in garbage.iter().enumerate() {
            total_time += g.len();
            if g.contains('M') {
                last_garbage[0] = i;
            }
            if g.contains('P') {
                last_garbage[1] = i;
            }
            if g.contains('G') {
                last_garbage[2] = i;
            }
        }

        for i in 0..2 {
            total_time += travel.iter().take(last_garbage[i + 1]).sum::<i32>();
        }

        total_time
    }
}