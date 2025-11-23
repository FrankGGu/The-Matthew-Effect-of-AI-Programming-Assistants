use std::collections::HashMap;

impl Solution {
    pub fn most_popular_creator(creators: Vec<String>, ids: Vec<String>, views: Vec<i32>) -> Vec<Vec<String>> {
        let mut creator_data: HashMap<String, (i64, i32, String)> = HashMap::new();
        let mut max_total_views: i64 = 0;

        for i in 0..creators.len() {
            let creator = &creators[i];
            let id = &ids[i];
            let view = views[i];

            let entry = creator_data.entry(creator.clone());

            let (total_views_ref, max_video_views_ref, max_video_id_ref) = entry
                .and_modify(|(total_views, max_video_views, max_video_id)| {
                    *total_views += view as i64;
                    if view > *max_video_views {
                        *max_video_views = view;
                        *max_video_id = id.clone();
                    } else if view == *max_video_views {
                        if id.as_str() < max_video_id.as_str() {
                            *max_video_id = id.clone();
                        }
                    }
                })
                .or_insert((view as i64, view, id.clone()));

            if *total_views_ref > max_total_views {
                max_total_views = *total_views_ref;
            }
        }

        let mut result: Vec<Vec<String>> = Vec::new();
        for (creator_name, (total_views, _, video_id)) in creator_data {
            if total_views == max_total_views {
                result.push(vec![creator_name, video_id]);
            }
        }

        result
    }
}