use std::collections::BTreeMap;
use std::cmp::Ordering;

const MOD: i64 = 1_000_000_007;

struct Event {
    x: i32,
    y1: i32,
    y2: i32,
    event_type: i32, // 1 for start, -1 for end
}

impl PartialEq for Event {
    fn eq(&self, other: &Self) -> bool {
        self.x == other.x && self.event_type == other.event_type
    }
}

impl Eq for Event {}

impl PartialOrd for Event {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Event {
    fn cmp(&self, other: &Self) -> Ordering {
        self.x.cmp(&other.x)
            .then_with(|| self.event_type.cmp(&other.event_type))
    }
}

impl Solution {
    pub fn rectangle_area(rectangles: Vec<Vec<i32>>) -> i32 {
        let mut events: Vec<Event> = Vec::new();
        for rect in rectangles {
            let x1 = rect[0];
            let y1 = rect[1];
            let x2 = rect[2];
            let y2 = rect[3];
            // Problem constraints guarantee x1 < x2 and y1 < y2, so no need to check for zero-area rectangles
            events.push(Event { x: x1, y1, y2, event_type: 1 });
            events.push(Event { x: x2, y1, y2, event_type: -1 });
        }

        // Sort events by x-coordinate, then by event_type (start events before end events)
        events.sort_unstable();

        let mut total_area: i64 = 0;
        // BTreeMap to store active y-intervals. Key: y-coordinate, Value: count of active rectangles covering this y-coordinate
        let mut active_y_intervals: BTreeMap<i32, i32> = BTreeMap::new();
        let mut last_x: i32 = events[0].x; // Initialize with the x-coordinate of the first event

        for event in events {
            let current_x = event.x;

            // Calculate the area of the strip between last_x and current_x
            // The height of this strip is the total length of the union of active y-intervals
            // The active_y_intervals state reflects the configuration *before* processing the current event
            if current_x > last_x {
                let current_y_length = Self::calculate_current_y_length(&active_y_intervals);
                total_area = (total_area + (current_x - last_x) as i64 * current_y_length) % MOD;
            }

            // Update active_y_intervals for the current event
            // For a start event (type 1), increment count at y1, decrement at y2
            // For an end event (type -1), decrement count at y1, increment at y2
            *active_y_intervals.entry(event.y1).or_insert(0) += event.event_type;
            *active_y_intervals.entry(event.y2).or_insert(0) -= event.event_type;

            // Update last_x for the next iteration
            last_x = current_x;
        }

        total_area as i32
    }

    // Calculates the total length of the union of active y-intervals
    fn calculate_current_y_length(active_y_intervals: &BTreeMap<i32, i32>) -> i64 {
        let mut total_length = 0;
        let mut active_count = 0;
        let mut prev_y = 0; // Will be updated by the first entry in the map

        for (&y, &delta) in active_y_intervals.iter() {
            // If active_count > 0, the segment from prev_y to y is covered by at least one rectangle
            if active_count > 0 {
                total_length += (y - prev_y) as i64;
            }
            active_count += delta;
            prev_y = y;
        }
        total_length
    }
}