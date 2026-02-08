use std::collections::HashMap;

impl Solution {
    pub fn describe_the_painting(paint: Vec<Vec<i64>>) -> Vec<Vec<i64>> {
        let mut colors_to_intervals: HashMap<i64, Vec<Vec<i64>>> = HashMap::new();

        // Group segments by color
        for segment in paint {
            let start = segment[0];
            let end = segment[1];
            let color = segment[2];
            colors_to_intervals.entry(color).or_default().push(vec![start, end]);
        }

        let mut result: Vec<Vec<i64>> = Vec::new();

        // For each color, merge its intervals and calculate total length
        for (color, intervals) in colors_to_intervals {
            let mut current_intervals = intervals;

            // Sort intervals for the current color by their start points
            current_intervals.sort_unstable_by(|a, b| a[0].cmp(&b[0]));

            let mut merged_intervals: Vec<Vec<i64>> = Vec::new();

            if current_intervals.is_empty() {
                continue; // Should not happen if entry exists, but good for safety
            }

            // Initialize with the first interval
            let mut current_start = current_intervals[0][0];
            let mut current_end = current_intervals[0][1];

            // Iterate through the sorted intervals to merge overlapping ones
            for i in 1..current_intervals.len() {
                let segment = &current_intervals[i];
                let start = segment[0];
                let end = segment[1];

                if start <= current_end {
                    // Overlap: extend the current merged interval
                    current_end = current_end.max(end);
                } else {
                    // No overlap: add the current merged interval to the list
                    // and start a new merged interval with the current segment
                    merged_intervals.push(vec![current_start, current_end]);
                    current_start = start;
                    current_end = end;
                }
            }
            // Add the last merged interval
            merged_intervals.push(vec![current_start, current_end]);

            // Calculate the total length for the current color
            let mut total_length = 0;
            for interval in merged_intervals {
                total_length += interval[1] - interval[0];
            }

            // Only add to result if the total length is positive
            if total_length > 0 {
                result.push(vec![color, total_length]);
            }
        }

        // Sort the final result by color ID
        result.sort_unstable_by(|a, b| a[0].cmp(&b[0]));

        result
    }
}