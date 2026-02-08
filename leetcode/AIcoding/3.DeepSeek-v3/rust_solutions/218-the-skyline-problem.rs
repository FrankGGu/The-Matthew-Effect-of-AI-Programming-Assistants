use std::collections::BinaryHeap;

struct Point {
    x: i32,
    height: i32,
    is_start: bool,
}

impl Solution {
    pub fn get_skyline(buildings: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut points = Vec::new();
        for building in buildings {
            let (l, r, h) = (building[0], building[1], building[2]);
            points.push(Point {
                x: l,
                height: h,
                is_start: true,
            });
            points.push(Point {
                x: r,
                height: h,
                is_start: false,
            });
        }

        points.sort_by(|a, b| {
            if a.x != b.x {
                a.x.cmp(&b.x)
            } else if a.is_start != b.is_start {
                if a.is_start {
                    std::cmp::Ordering::Less
                } else {
                    std::cmp::Ordering::Greater
                }
            } else if a.is_start {
                b.height.cmp(&a.height)
            } else {
                a.height.cmp(&b.height)
            }
        });

        let mut heap = BinaryHeap::new();
        let mut removed = BinaryHeap::new();
        heap.push(0);
        let mut result = Vec::new();
        let mut prev_max = 0;

        for point in points {
            if point.is_start {
                heap.push(point.height);
            } else {
                removed.push(point.height);
                while let Some(&top) = heap.peek() {
                    while let Some(&r_top) = removed.peek() {
                        if top == r_top {
                            heap.pop();
                            removed.pop();
                        } else {
                            break;
                        }
                    }
                    break;
                }
            }

            let current_max = *heap.peek().unwrap();
            if current_max != prev_max {
                result.push(vec![point.x, current_max]);
                prev_max = current_max;
            }
        }

        result
    }
}