impl Solution {
    pub fn video_stitching(clips: Vec<Vec<i32>>, time: i32) -> i32 {
        let mut clips = clips;
        clips.sort_unstable_by_key(|c| (c[0], -c[1]));

        let mut res = 0;
        let mut end = 0;
        let mut i = 0;
        let n = clips.len();

        while end < time && i < n {
            if clips[i][0] > end {
                return -1;
            }
            let mut max_end = end;
            while i < n && clips[i][0] <= end {
                max_end = max_end.max(clips[i][1]);
                i += 1;
            }
            res += 1;
            end = max_end;
        }

        if end >= time { res } else { -1 }
    }
}