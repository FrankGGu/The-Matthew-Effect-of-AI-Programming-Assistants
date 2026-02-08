use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn maximum_points_inside_the_square(points: Vec<Vec<i32>>, tags: Vec<String>) -> i32 {
        let mut tag_to_min_s: HashMap<String, i32> = HashMap::new();
        let mut tag_counts: HashMap<String, i32> = HashMap::new();

        for i in 0..points.len() {
            let x = points[i][0];
            let y = points[i][1];
            let tag = &tags[i];

            let current_s_for_point = max(x.abs(), y.abs());

            // Update the minimum 's' required to contain all points of this tag
            let s_entry = tag_to_min_s.entry(tag.clone()).or_insert(0);
            *s_entry = max(*s_entry, current_s_for_point);

            // Count occurrences of each tag
            *tag_counts.entry(tag.clone()).or_insert(0) += 1;
        }

        let mut valid_s_values: Vec<i32> = Vec::new();

        // Iterate through the calculated minimum 's' values for each unique tag
        for (tag, s_val) in tag_to_min_s.into_iter() {
            // A tag can only be included if it appears exactly once in the input.
            // If a tag appears multiple times, and any of its points are in the square,
            // then by condition 2, all its points must be in the square.
            // This would violate condition 1 (points must have distinct tags)
            // if there's more than one point with that tag.
            if *tag_counts.get(&tag).unwrap_or(&0) == 1 {
                valid_s_values.push(s_val);
            }
        }

        // The problem asks for the maximum number of points.
        // Each point corresponds to a unique-occurrence tag.
        // If we select a square with side '2s_chosen', we can include all unique-occurrence tags T
        // for which their required 's_T' (to contain all points of tag T) is less than or equal to 's_chosen'.
        // Since we are only considering tags that appear exactly once, each such tag corresponds to exactly one point.
        // The maximum number of points we can include is simply the total count of such unique-occurrence tags.
        // Sorting `valid_s_values` is not strictly necessary for just the count, but it's a common step
        // in problems involving 's' values and doesn't affect correctness.
        // valid_s_values.sort_unstable(); 

        valid_s_values.len() as i32
    }
}