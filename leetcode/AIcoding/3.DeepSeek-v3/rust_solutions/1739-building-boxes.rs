impl Solution {
    pub fn minimum_boxes(n: i32) -> i32 {
        let mut total = 0;
        let mut level = 0;
        let mut next_level_boxes = 0;

        while total < n {
            level += 1;
            next_level_boxes += level;
            total += next_level_boxes;
        }

        if total == n {
            return next_level_boxes;
        }

        total -= next_level_boxes;
        next_level_boxes -= level;
        level = 0;

        while total < n {
            level += 1;
            total += level;
        }

        next_level_boxes + level
    }
}