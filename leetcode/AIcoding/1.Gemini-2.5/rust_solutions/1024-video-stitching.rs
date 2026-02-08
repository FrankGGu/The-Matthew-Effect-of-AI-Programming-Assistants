use std::cmp::max;

impl Solution {
    pub fn video_stitching(clips: Vec<Vec<i32>>, t: i32) -> i32 {
        if t == 0 {
            return 0;
        }

        let mut clips = clips;
        clips.sort_unstable_by_key(|c| c[0]);

        let mut num_clips = 0;
        let mut current_end = 0; // The current point we have covered up to
        let mut max_reach = 0;   // The furthest point we can reach with clips starting at or before current_end
        let mut i = 0;           // Pointer for iterating through sorted clips

        while current_end < t {
            // Find all clips that start at or before `current_end`
            // and find the one that extends furthest.
            while i < clips.len() && clips[i][0] <= current_end {
                max_reach = max(max_reach, clips[i][1]);
                i += 1;
            }

            // If we couldn't extend max_reach beyond current_end, it's impossible
            // This means there's a gap or no clip can extend coverage further.
            if max_reach <= current_end {
                return -1;
            }

            // We picked a "best" clip (or effectively combined multiple) that extends to `max_reach`.
            // Increment the count of clips used.
            num_clips += 1;
            // Update `current_end` to the new maximum reach achieved.
            current_end = max_reach;

            // If we have covered the target time `t` or beyond, we are done.
            if current_end >= t {
                return num_clips;
            }
        }

        // This part of the code should ideally be unreachable because
        // the loop condition `current_end < t` ensures that if it exits,
        // `current_end >= t`, and the inner `if current_end >= t` would have
        // already returned `num_clips`.
        unreachable!(); 
    }
}