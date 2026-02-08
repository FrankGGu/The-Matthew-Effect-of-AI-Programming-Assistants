use std::collections::HashSet;

pub fn avoid_flood(rains: Vec<i32>) -> Vec<i32> {
    let mut result = vec![-1; rains.len()];
    let mut lake = HashSet::new();
    let mut dry_days = Vec::new();

    for (day, rain) in rains.iter().enumerate() {
        if *rain > 0 {
            if lake.contains(&rain) {
                return vec![]; // Flood occurs
            }
            lake.insert(rain);
            result[day] = -1; // It's raining, can't dry
        } else {
            dry_days.push(day); // Store dry days
            result[day] = 1; // Mark as dry day
        }
    }

    for (day, rain) in rains.iter().enumerate() {
        if *rain > 0 {
            lake.remove(&rain); // Remove the lake after rain
            if let Some(dry_day) = dry_days.pop() {
                result[dry_day] = rain; // Use a dry day to prevent flood
            }
        }
    }

    result
}