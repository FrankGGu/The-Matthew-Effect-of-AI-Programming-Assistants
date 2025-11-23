impl Solution {
    pub fn video_stitching(clips: Vec<Vec<i32>>, time: i32) -> i32 {
        let mut max_reach = vec![0; time as usize + 1];
        for clip in &clips {
            if clip[0] <= time {
                max_reach[clip[0] as usize] = max_reach[clip[0] as usize].max(clip[1]);
            }
        }

        let mut reach = 0;
        let mut next_reach = 0;
        let mut count = 0;

        for i in 0..time as usize {
            next_reach = next_reach.max(max_reach[i]);
            if i == reach {
                if reach == next_reach {
                    return -1;
                }
                reach = next_reach;
                count += 1;
            }
        }

        if reach < time as usize {
            if next_reach >= time {
                count +=1;
            } else {
                return -1;
            }
        }

        count
    }
}