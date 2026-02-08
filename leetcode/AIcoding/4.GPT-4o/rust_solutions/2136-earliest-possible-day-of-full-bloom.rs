use std::cmp;

pub fn earliest_full_bloom(plants: Vec<i32>, grow_time: Vec<i32>) -> i32 {
    let mut plants: Vec<(i32, i32)> = plants.into_iter().zip(grow_time).collect();
    plants.sort_by_key(|&(plant, grow)| -grow);

    let mut curr_day = 0;
    let mut max_bloom_day = 0;

    for (plant, grow) in plants {
        curr_day += plant;
        max_bloom_day = cmp::max(max_bloom_day, curr_day + grow);
    }

    max_bloom_day
}