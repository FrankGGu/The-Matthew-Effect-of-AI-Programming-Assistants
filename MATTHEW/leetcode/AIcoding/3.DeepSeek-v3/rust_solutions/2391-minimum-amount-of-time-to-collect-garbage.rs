impl Solution {
    pub fn garbage_collection(garbage: Vec<String>, travel: Vec<i32>) -> i32 {
        let mut time = 0;
        let mut last_m = 0;
        let mut last_p = 0;
        let mut last_g = 0;

        for (i, s) in garbage.iter().enumerate() {
            time += s.len() as i32;
            if s.contains('M') {
                last_m = i;
            }
            if s.contains('P') {
                last_p = i;
            }
            if s.contains('G') {
                last_g = i;
            }
        }

        let mut prefix_sum = vec![0; travel.len() + 1];
        for i in 1..=travel.len() {
            prefix_sum[i] = prefix_sum[i - 1] + travel[i - 1];
        }

        time += prefix_sum[last_m];
        time += prefix_sum[last_p];
        time += prefix_sum[last_g];

        time
    }
}