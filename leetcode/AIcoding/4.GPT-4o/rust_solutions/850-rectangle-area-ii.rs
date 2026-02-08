pub fn rectangle_area(rectangles: Vec<Vec<i32>>) -> i32 {
    const MOD: i32 = 1_000_000_007;
    let mut events = vec![];
    for rect in &rectangles {
        events.push((rect[0], 1, rect[1], rect[3]));
        events.push((rect[2], -1, rect[1], rect[3]));
    }
    events.sort();

    let mut active_intervals = vec![];
    let mut last_x = 0;
    let mut area = 0;

    for (x, typ, y1, y2) in events {
        area = (area + (x - last_x) * calculate_height(&active_intervals) % MOD) % MOD;
        last_x = x;

        if typ == 1 {
            active_intervals.push((y1, y2));
        } else {
            active_intervals.retain(|&(start, end)| start != y1 || end != y2);
        }
    }

    area
}

fn calculate_height(intervals: &[(i32, i32)]) -> i32 {
    let mut height = 0;
    let mut current_start = -1;
    let mut current_end = -1;

    for &(start, end) in intervals {
        if start > current_end {
            height += current_end - current_start;
            current_start = start;
            current_end = end;
        } else {
            current_end = current_end.max(end);
        }
    }
    height += current_end - current_start;
    height
}