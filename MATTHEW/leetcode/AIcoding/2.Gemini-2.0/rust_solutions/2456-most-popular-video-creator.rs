use std::collections::HashMap;

impl Solution {
    pub fn most_popular_creator(creators: Vec<String>, ids: Vec<String>, views: Vec<i32>) -> Vec<Vec<String>> {
        let mut popularity: HashMap<String, i64> = HashMap::new();
        let mut best_video: HashMap<String, (String, i32)> = HashMap::new();

        for i in 0..creators.len() {
            let creator = &creators[i];
            let id = &ids[i];
            let view = views[i];

            *popularity.entry(creator.clone()).or_insert(0) += view as i64;

            best_video.entry(creator.clone()).or_insert((id.clone(), view));

            if let Some((current_id, current_view)) = best_video.get_mut(creator) {
                if view > *current_view {
                    *current_id = id.clone();
                    *current_view = view;
                } else if view == *current_view && id < current_id {
                    *current_id = id.clone();
                }
            }
        }

        let mut max_popularity: i64 = 0;
        for &p in popularity.values() {
            max_popularity = max_popularity.max(p);
        }

        let mut result: Vec<Vec<String>> = Vec::new();
        for (creator, p) in &popularity {
            if *p == max_popularity {
                if let Some((id, _)) = best_video.get(creator) {
                    result.push(vec![creator.clone(), id.clone()]);
                }
            }
        }

        result
    }
}