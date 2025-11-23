use std::collections::BTreeMap;

impl Solution {
    pub fn max_two_events(mut events: Vec<Vec<i32>>) -> i32 {
        // Sort events by their start times.
        events.sort_unstable_by_key(|e| e[0]);

        let mut max_total_value = 0;

        // dp_map stores (endTime, max_value_of_an_event_ending_at_or_before_this_endTime).
        // The values in dp_map are monotonically non-decreasing.
        // This structure allows efficient lookup of the best non-overlapping previous event.
        let mut dp_map: BTreeMap<i32, i32> = BTreeMap::new();
        dp_map.insert(0, 0); // Sentinel: An event ending at time 0 has value 0.

        for event in events {
            let s = event[0];
            let e = event[1];
            let v = event[2];

            // 1. Find the maximum value of a single event that ends strictly before 's'.
            // This is the best candidate for a first event if the current event 'v' is chosen as the second.
            let prev_max_val = dp_map
                .range(..s) // Get all entries with endTime < s
                .last()      // Get the one with the largest endTime (which will have the highest value due to monotonicity)
                .map(|(_, &val)| val)
                .unwrap_or(0); // If no such event, consider 0 value.

            // Update the overall maximum value:
            // This considers picking the current event 'v' alone (if prev_max_val is 0)
            // or picking 'v' combined with the best non-overlapping previous event.
            max_total_value = max_total_value.max(v + prev_max_val);

            // 2. Update dp_map with the current event (e, v).
            // Calculate the new maximum value for an event ending at or before 'e'.
            // This value should be the maximum of 'v' itself and the current max value
            // for any event ending at or before 'e'.
            let current_max_at_e = dp_map
                .range(..=e) // Get all entries with endTime <= e
                .last()      // Get the one with the largest endTime
                .map(|(_, &val)| val)
                .unwrap_or(0)
                .max(v);     // Compare with the current event's value

            // Only insert/update 'e' if 'current_max_at_e' is strictly greater than
            // the existing value at 'e' (if any), and also strictly greater than
            // the value of the entry immediately preceding 'e' (to maintain monotonicity and avoid redundancy).
            if let Some(&existing_val) = dp_map.get(&e) {
                if existing_val >= current_max_at_e {
                    continue; // No improvement at 'e', so no need to update.
                }
            }
            if let Some((&_prev_k, &prev_v)) = dp_map.range(..e).last() {
                if current_max_at_e <= prev_v {
                    continue; // New value at 'e' is not better than what ends before 'e', so no need to update.
                }
            }

            dp_map.insert(e, current_max_at_e);

            // Remove any subsequent entries that are now redundant.
            // An entry (k_after, val_after) is redundant if val_after <= current_max_at_e,
            // because 'e' now offers a better or equal value for a time point that is earlier or equal.
            let mut keys_to_remove = Vec::new();
            for (&k_after, &val_after) in dp_map.range((e + 1)..) {
                if val_after <= current_max_at_e {
                    keys_to_remove.push(k_after);
                } else {
                    break; // Since map values are non-decreasing, we can stop if we find a larger value.
                }
            }
            for k in keys_to_remove {
                dp_map.remove(&k);
            }
        }

        max_total_value
    }
}