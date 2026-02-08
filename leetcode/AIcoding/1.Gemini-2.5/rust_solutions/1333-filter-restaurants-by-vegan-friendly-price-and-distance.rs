impl Solution {
    pub fn filter_restaurants(restaurants: Vec<Vec<i32>>, vegan_friendly: i32, max_price: i32, max_distance: i32) -> Vec<i32> {
        let mut filtered_restaurants: Vec<&Vec<i32>> = Vec::new();

        for restaurant in &restaurants {
            let r_vegan_friendly = restaurant[2];
            let r_price = restaurant[3];
            let r_distance = restaurant[4];

            let mut passes_filter = true;

            if vegan_friendly == 1 && r_vegan_friendly == 0 {
                passes_filter = false;
            }

            if passes_filter && r_price > max_price {
                passes_filter = false;
            }

            if passes_filter && r_distance > max_distance {
                passes_filter = false;
            }

            if passes_filter {
                filtered_restaurants.push(restaurant);
            }
        }

        filtered_restaurants.sort_by(|a, b| {
            let rating_a = a[1];
            let rating_b = b[1];
            let id_a = a[0];
            let id_b = b[0];

            if rating_a != rating_b {
                rating_b.cmp(&rating_a)
            } else {
                id_b.cmp(&id_a)
            }
        });

        let mut result_ids: Vec<i32> = Vec::new();
        for restaurant in filtered_restaurants {
            result_ids.push(restaurant[0]);
        }

        result_ids
    }
}