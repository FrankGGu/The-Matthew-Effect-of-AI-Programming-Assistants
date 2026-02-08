use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn watched_videos_by_friends(
        watched_videos: Vec<Vec<String>>,
        friends: Vec<Vec<i32>>,
        id: i32,
        level: i32,
    ) -> Vec<String> {
        let n = friends.len();
        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back((id as usize, 0));
        visited[id as usize] = true;

        let mut friends_at_level = Vec::new();

        while let Some((curr, curr_level)) = queue.pop_front() {
            if curr_level == level {
                friends_at_level.push(curr);
                continue;
            }

            if curr_level > level {
                continue;
            }

            for &neighbor in &friends[curr] {
                if !visited[neighbor as usize] {
                    visited[neighbor as usize] = true;
                    queue.push_back((neighbor as usize, curr_level + 1));
                }
            }
        }

        let mut video_counts: HashMap<String, i32> = HashMap::new();
        for friend_idx in friends_at_level {
            for video in &watched_videos[friend_idx] {
                *video_counts.entry(video.clone()).or_insert(0) += 1;
            }
        }

        let mut videos: Vec<String> = video_counts.keys().cloned().collect();
        videos.sort_by(|a, b| {
            let count_a = video_counts.get(a).unwrap();
            let count_b = video_counts.get(b).unwrap();
            if count_a != count_b {
                count_a.cmp(count_b)
            } else {
                a.cmp(b)
            }
        });

        videos
    }
}