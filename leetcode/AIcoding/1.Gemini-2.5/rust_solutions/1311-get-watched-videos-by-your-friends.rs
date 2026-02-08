use std::collections::{VecDeque, HashMap, HashSet};

impl Solution {
    pub fn get_watched_videos_by_friends(watched_videos: Vec<Vec<String>>, friends: Vec<Vec<i32>>, id: i32, level: i32) -> Vec<String> {
        let mut queue: VecDeque<i32> = VecDeque::new();
        let mut visited: HashSet<i32> = HashSet::new();

        queue.push_back(id);
        visited.insert(id);

        let mut current_level = 0;
        let mut friends_at_target_level: Vec<i32> = Vec::new();

        while !queue.is_empty() && current_level <= level {
            let level_size = queue.len();
            if current_level == level {
                friends_at_target_level.extend(queue.iter());
                break;
            }

            for _ in 0..level_size {
                if let Some(person_id) = queue.pop_front() {
                    for &friend_id in friends[person_id as usize].iter() {
                        if visited.insert(friend_id) {
                            queue.push_back(friend_id);
                        }
                    }
                }
            }
            current_level += 1;
        }

        let mut video_counts: HashMap<String, i32> = HashMap::new();

        for &person_id in friends_at_target_level.iter() {
            for video_name in watched_videos[person_id as usize].iter() {
                *video_counts.entry(video_name.clone()).or_insert(0) += 1;
            }
        }

        let mut result: Vec<(String, i32)> = video_counts.into_iter().collect();

        result.sort_by(|a, b| {
            if a.1 != b.1 {
                a.1.cmp(&b.1)
            } else {
                a.0.cmp(&b.0)
            }
        });

        result.into_iter().map(|(name, _)| name).collect()
    }
}