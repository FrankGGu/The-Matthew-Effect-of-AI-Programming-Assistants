impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn video_stitching(mut clips: Vec<Vec<i32>>, mut n: i32) -> i32 {
        clips.sort_by(|a, b| {
            if a[0] != b[0] {
                a[0].cmp(&b[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut res = 0;
        let mut curr_end = 0;
        let mut next_end = 0;
        let mut i = 0;

        while curr_end < n {
            while i < clips.len() && clips[i][0] <= curr_end {
                next_end = next_end.max(clips[i][1]);
                i += 1;
            }

            if curr_end == next_end {
                return -1;
            }

            curr_end = next_end;
            res += 1;
        }

        res
    }
}
}