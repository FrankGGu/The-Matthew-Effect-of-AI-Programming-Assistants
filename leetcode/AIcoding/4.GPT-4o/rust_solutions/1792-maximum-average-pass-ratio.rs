use std::cmp::Ordering;
use std::collections::BinaryHeap;

pub fn max_average_ratio(classes: Vec<Vec<i32>>, extra_students: i32) -> f64 {
    let mut heap = BinaryHeap::new();

    for class in classes {
        let (pass, total) = (class[0], class[1]);
        heap.push((pass as f64 / total as f64, pass, total));
    }

    let mut extra = extra_students;

    while extra > 0 {
        if let Some((_, pass, total)) = heap.pop() {
            heap.push(((pass + 1) as f64 / (total + 1) as f64, pass + 1, total + 1));
            extra -= 1;
        }
    }

    let mut total_avg = 0.0;
    let mut total_classes = 0;

    while let Some((avg, pass, total)) = heap.pop() {
        total_avg += avg * total as f64;
        total_classes += total;
    }

    total_avg / total_classes as f64
}