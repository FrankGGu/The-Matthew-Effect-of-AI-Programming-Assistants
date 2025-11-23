impl Solution {
    pub fn num_times_all_lights_on(flips: Vec<i32>) -> i32 {
        let mut max_on_index = 0;
        let mut aligned_moments = 0;

        for (i, &light_to_turn_on) in flips.iter().enumerate() {
            // 'k' represents the current number of lights turned on,
            // and also the expected maximum index if lights 1 to k are all on.
            let k = (i + 1) as i32;

            // Update the maximum index of a light that has been turned on so far.
            max_on_index = max_on_index.max(light_to_turn_on);

            // If the maximum index of a light turned on so far is equal to the
            // total number of lights turned on (k), it implies that all lights
            // from 1 to k must be on, and all lights greater than k must be off.
            if max_on_index == k {
                aligned_moments += 1;
            }
        }

        aligned_moments
    }
}