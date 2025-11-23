impl Solution {

use std::collections::{HashMap, HashSet};

#[derive(Debug, PartialEq, Eq)]
struct User {
    id: i32,
    friends: Vec<i32>,
    watched_videos: Vec<String>,
}

impl User {
    fn new(id: i32, friends: Vec<i32>, watched_videos: Vec<String>) -> Self {
        User {
            id,
            friends,
            watched_videos,
        }
    }
}

fn get_friends_videos(users: Vec<User>, id: i32) -> Vec<String> {
    let mut friend_set = HashSet::new();
    let mut queue = vec![id];
    let mut visited = HashSet::new();
    visited.insert(id);

    while let Some(current) = queue.pop() {
        for &friend in &users.iter().find(|u| u.id == current).unwrap().friends {
            if !visited.contains(&friend) {
                visited.insert(friend);
                friend_set.insert(friend);
                queue.push(friend);
            }
        }
    }

    let mut videos = HashMap::new();
    for &friend_id in &friend_set {
        for video in &users.iter().find(|u| u.id == friend_id).unwrap().watched_videos {
            *videos.entry(video.clone()).or_insert(0) += 1;
        }
    }

    let mut result: Vec<_> = videos.into_iter().collect();
    result.sort_by(|a, b| {
        if a.1 != b.1 {
            b.1.cmp(&a.1)
        } else {
            a.0.cmp(&b.0)
        }
    });

    result.into_iter().map(|x| x.0).collect()
}
}