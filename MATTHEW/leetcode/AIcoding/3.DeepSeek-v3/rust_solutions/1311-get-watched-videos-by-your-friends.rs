use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn watched_videos_by_friends(watched_videos: Vec<Vec<String>>, friends: Vec<Vec<i32>>, id: i32, level: i32) -> Vec<String> {
        let n = friends.len();
        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back(id as usize);
        visited[id as usize] = true;
        let mut current_level = 0;

        while !queue.is_empty() && current_level < level {
            let size = queue.len();
            for _ in 0..size {
                let current = queue.pop_front().unwrap();
                for &friend in &friends[current] {
                    let friend = friend as usize;
                    if !visited[friend] {
                        visited[friend] = true;
                        queue.push_back(friend);
                    }
                }
            }
            current_level += 1;
        }

        let mut video_counts = HashMap::new();
        for person in queue {
            for video in &watched_videos[person] {
                *video_counts.entry(video.clone()).or_insert(0) += 1;
            }
        }

        let mut videos: Vec<(String, i32)> = video_counts.into_iter().collect();
        videos.sort_by(|a, b| {
            if a.1 == b.1 {
                a.0.cmp(&b.0)
            } else {
                a.1.cmp(&b.1)
            }
        });

        videos.into_iter().map(|(video, _)| video).collect()
    }
}