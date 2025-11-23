impl Solution {
    pub fn filter_restaurants(restaurants: Vec<Vec<i32>>, vegan_friendly: i32, max_price: i32, max_distance: i32) -> Vec<i32> {
        let mut filtered: Vec<_> = restaurants
            .into_iter()
            .filter(|r| {
                (vegan_friendly == 0 || r[2] == vegan_friendly) && r[3] <= max_price && r[4] <= max_distance
            })
            .collect();

        filtered.sort_by(|a, b| {
            if b[1] != a[1] {
                b[1].cmp(&a[1])
            } else {
                b[0].cmp(&a[0])
            }
        });

        filtered.into_iter().map(|r| r[0]).collect()
    }
}