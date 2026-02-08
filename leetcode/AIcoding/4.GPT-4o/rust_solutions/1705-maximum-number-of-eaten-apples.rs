pub fn eaten_apples(apples: Vec<i32>, days: Vec<i32>) -> i32 {
    use std::collections::BinaryHeap;

    let mut max_heap = BinaryHeap::new();
    let mut total_eaten = 0;
    let mut n = apples.len();

    for day in 0..n {
        if apples[day] > 0 {
            max_heap.push((day as i32 + days[day], apples[day]));
        }

        while let Some(&(expire_day, count)) = max_heap.peek() {
            if expire_day <= day as i32 {
                max_heap.pop();
            } else {
                break;
            }
        }

        if let Some(&(expire_day, count)) = max_heap.peek() {
            total_eaten += 1;
            if count > 1 {
                max_heap.pop();
                max_heap.push((expire_day, count - 1));
            } else {
                max_heap.pop();
            }
        }
    }

    for day in n.. {
        while let Some(&(expire_day, count)) = max_heap.peek() {
            if expire_day <= day as i32 {
                max_heap.pop();
            } else {
                break;
            }
        }

        if let Some(&(expire_day, count)) = max_heap.peek() {
            total_eaten += 1;
            if count > 1 {
                max_heap.pop();
                max_heap.push((expire_day, count - 1));
            } else {
                max_heap.pop();
            }
        } else {
            break;
        }
    }

    total_eaten
}