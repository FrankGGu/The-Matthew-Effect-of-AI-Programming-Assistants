impl Solution {
    pub fn video_stitching(clips: Vec<Vec<i32>>, t: i32) -> i32 {
        let mut clips = clips;
        clips.sort_unstable_by_key(|clip| clip[0]);

        let mut clips_count = 0;
        let mut last_reach = 0;
        let mut current_max_reach = 0;
        let mut clip_idx = 0;

        while last_reach < t {
            clips_count += 1;

            while clip_idx < clips.len() && clips[clip_idx][0] <= last_reach {
                current_max_reach = std::cmp::max(current_max_reach, clips[clip_idx][1]);
                clip_idx += 1;
            }

            if current_max_reach <= last_reach {
                return -1;
            }

            last_reach = current_max_reach;
        }

        clips_count
    }
}