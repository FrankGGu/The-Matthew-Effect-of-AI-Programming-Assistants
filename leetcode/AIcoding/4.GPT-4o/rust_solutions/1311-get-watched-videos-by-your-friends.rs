use std::collections::{HashMap, HashSet};

pub fn watched_videos_by_friends(watched: Vec<Vec<String>>, friends: Vec<Vec<i32>>, id: i32, level: i32) -> Vec<String> {
    let mut visited = HashSet::new();
    let mut queue = vec![id];
    visited.insert(id);

    for _ in 0..level {
        let mut next_queue = vec![];
        for friend in queue {
            for &f in &friends[friend as usize] {
                if visited.insert(f) {
                    next_queue.push(f);
                }
            }
        }
        queue = next_queue;
    }

    let mut video_count = HashMap::new();
    for friend in queue {
        for video in &watched[friend as usize] {
            *video_count.entry(video.clone()).or_insert(0) += 1;
        }
    }

    let mut result: Vec<_> = video_count.into_iter().collect();
    result.sort_by(|(video1, count1), (video2, count2)| {
        if count1 == count2 {
            video1.cmp(video2)
        } else {
            count1.cmp(count2)
        }
    });

    result.into_iter().map(|(video, _)| video).collect()
}