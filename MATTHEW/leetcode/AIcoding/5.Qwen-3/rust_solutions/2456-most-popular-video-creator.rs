impl Solution {

use std::collections::{HashMap, BTreeSet};

#[derive(Debug, PartialEq, Eq)]
pub struct Video {
    pub id: String,
    pub views: i32,
}

pub fn most_popular_video_creator(creators: Vec<String>, videos: Vec<String>, view_counts: Vec<i32>) -> Vec<String> {
    let mut creator_views = HashMap::new();
    let mut creator_videos = HashMap::new();

    for i in 0..creators.len() {
        let creator = &creators[i];
        let video = &videos[i];
        let count = view_counts[i];

        creator_views.entry(creator).or_insert(0);
        *creator_views.get_mut(creator).unwrap() += count;

        creator_videos.entry(creator).or_insert(BTreeSet::new());
        creator_videos.get_mut(creator).unwrap().insert((count, video.clone()));
    }

    let mut max_views = i32::MIN;
    let mut result = Vec::new();

    for (creator, views) in &creator_views {
        if *views > max_views {
            max_views = *views;
            result.clear();
            result.push(creator.clone());
        } else if *views == max_views {
            result.push(creator.clone());
        }
    }

    result
}
}