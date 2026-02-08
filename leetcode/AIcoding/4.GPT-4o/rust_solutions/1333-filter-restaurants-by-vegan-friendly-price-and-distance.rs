use std::cmp::Ordering;

pub fn filter_restaurants(restaurants: Vec<Vec<i32>>, vegan_friendly: i32, max_price: i32, max_distance: i32) -> Vec<Vec<i32>> {
    let mut filtered: Vec<Vec<i32>> = restaurants
        .into_iter()
        .filter(|r| {
            (vegan_friendly == 0 || r[2] == 1) && r[3] <= max_price && r[4] <= max_distance
        })
        .collect();

    filtered.sort_by(|a, b| {
        match a[1].cmp(&b[1]) {
            Ordering::Equal => b[0].cmp(&a[0]),
            other => other,
        }
    });

    filtered
}