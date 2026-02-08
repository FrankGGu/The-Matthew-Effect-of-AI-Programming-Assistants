pub fn num_bridges(positions: Vec<Vec<i32>>) -> i32 {
    let mut positions = positions;
    positions.sort_unstable();
    let mut count = 0;
    let mut last_position = i32::MIN;

    for pos in positions {
        if pos[0] > last_position {
            count += 1;
            last_position = pos[1];
        } else {
            last_position = last_position.max(pos[1]);
        }
    }
    count
}