use std::collections::HashMap;

pub fn most_popular_video_creator(creators: Vec<String>, ids: Vec<String>, views: Vec<i32>) -> Vec<Vec<String>> {
    let mut creator_views: HashMap<String, i64> = HashMap::new();
    let mut video_views: HashMap<String, i64> = HashMap::new();

    for i in 0..creators.len() {
        *creator_views.entry(creators[i].clone()).or_insert(0) += views[i] as i64;
        *video_views.entry(ids[i].clone()).or_insert(0) += views[i] as i64;
    }

    let max_views = creator_views.values().cloned().max().unwrap_or(0);
    let mut popular_creators: Vec<Vec<String>> = vec![];

    for (creator, total_views) in creator_views.iter() {
        if *total_views == max_views {
            let mut videos: Vec<String> = video_views.iter()
                .filter(|(id, _)| creators
                    .iter()
                    .zip(ids.iter())
                    .any(|(c, v)| c == creator && v == id))
                .map(|(id, &views)| (id.clone(), views))
                .collect();
            videos.sort_by(|a, b| b.1.cmp(&a.1).then_with(|| a.0.cmp(&b.0)));
            let max_video_views = videos.first().map(|&(_, v)| v).unwrap_or(0);
            let video_ids: Vec<String> = videos.into_iter()
                .filter(|&(_, v)| v == max_video_views)
                .map(|(id, _)| id)
                .collect();
            popular_creators.push(vec![creator.clone()].into_iter().chain(video_ids).collect());
        }
    }

    popular_creators
}