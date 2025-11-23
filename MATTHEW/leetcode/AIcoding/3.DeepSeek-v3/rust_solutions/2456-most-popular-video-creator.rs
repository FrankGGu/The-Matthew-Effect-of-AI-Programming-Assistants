use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn most_popular_creator(creators: Vec<String>, ids: Vec<String>, views: Vec<i32>) -> Vec<Vec<String>> {
        let mut creator_total_views = HashMap::new();
        let mut creator_videos = HashMap::new();

        for i in 0..creators.len() {
            let creator = &creators[i];
            let id = &ids[i];
            let view = views[i];

            *creator_total_views.entry(creator).or_insert(0) += view;

            let entry = creator_videos.entry(creator).or_insert(Vec::new());
            entry.push((id, view));
        }

        let max_total = *creator_total_views.values().max().unwrap_or(&0);
        let popular_creators: HashSet<_> = creator_total_views
            .iter()
            .filter(|&(_, &total)| total == max_total)
            .map(|(&creator, _)| creator)
            .collect();

        let mut result = Vec::new();
        for creator in popular_creators {
            let videos = creator_videos.get(creator).unwrap();
            let mut max_view = -1;
            let mut best_id = "";

            for &(id, view) in videos {
                if view > max_view || (view == max_view && id < best_id) {
                    max_view = view;
                    best_id = id;
                }
            }

            result.push(vec![creator.clone(), best_id.to_string()]);
        }

        result.sort();
        result
    }
}