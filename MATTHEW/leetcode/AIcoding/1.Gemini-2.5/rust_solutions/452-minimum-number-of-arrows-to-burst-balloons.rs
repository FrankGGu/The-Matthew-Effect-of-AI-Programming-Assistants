impl Solution {
    pub fn find_min_arrow_shots(mut points: Vec<Vec<i32>>) -> i32 {
        if points.is_empty() {
            return 0;
        }

        // Sort balloons by their end points.
        points.sort_by(|a, b| a[1].cmp(&b[1]));

        let mut arrows = 0;
        let mut last_arrow_pos = i32::MIN; // Represents the position of the last arrow shot

        for balloon in points {
            let start = balloon[0];
            let end = balloon[1];

            // If the current balloon starts after the last arrow's position,
            // we need a new arrow.
            if start > last_arrow_pos {
                arrows += 1;
                // Shoot the new arrow at the end of the current balloon.
                // This maximizes the chance of bursting subsequent balloons.
                last_arrow_pos = end;
            }
            // If start <= last_arrow_pos, this balloon is already burst by the current arrow.
            // No new arrow needed.
        }

        arrows
    }
}