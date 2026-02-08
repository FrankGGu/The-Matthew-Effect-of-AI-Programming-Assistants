use std::collections::HashSet;

pub fn min_area(rectangles: Vec<Vec<i32>>) -> i32 {
    let mut x_coords = HashSet::new();
    let mut y_coords = HashSet::new();

    for rect in &rectangles {
        x_coords.insert(rect[0]);
        x_coords.insert(rect[2]);
        y_coords.insert(rect[1]);
        y_coords.insert(rect[3]);
    }

    let x_coords: Vec<i32> = x_coords.into_iter().collect();
    let y_coords: Vec<i32> = y_coords.into_iter().collect();

    let min_x = *x_coords.iter().min().unwrap();
    let max_x = *x_coords.iter().max().unwrap();
    let min_y = *y_coords.iter().min().unwrap();
    let max_y = *y_coords.iter().max().unwrap();

    (max_x - min_x) * (max_y - min_y)
}